
import '../../../lib_exports.dart';

import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl();
  @override
  Future<Either<String, UserData>> getUserProfile() async {
    try {
      final user = await _userDocument.get();
      return right(user.data()!);
    } on FirebaseException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateUserProfile({
    required Uint8List? file,
    required String name,
    required String phone,
    required UserData user,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final uid = currentUser.uid;

    try {
      UserData userData;
      if (file != null) {
        final image = await uploadImage(file, 'images/user/$uid');
        userData = user.copyWith(
          image: image,
          name: name,
          phone: phone,
        );
      }

      userData = user.copyWith(
        name: name,
        phone: phone,
      );

      await _userDocument.update(userData.toMap());
      await getUserProfile();
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateUserPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    try {
      final credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: oldPassword,
      );
      await currentUser.reauthenticateWithCredential(credential);
      await currentUser.updatePassword(newPassword);

      return right(unit);
    } on FirebaseException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseStorage.instance.ref().child('images/user/$uid').delete();
      await _userDocument.delete();
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  DocumentReference<UserData> get _userDocument {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<UserData> document = FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(uid)
        .withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap(),
        );

    return document;
  }
}
