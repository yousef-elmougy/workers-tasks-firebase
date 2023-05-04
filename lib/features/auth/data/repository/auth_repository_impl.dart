import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/functions/upload_image.dart';
import '../model/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl();

  @override
  Future<Either<String, Unit>> createUser({
    required String name,
    required String uid,
    required String email,
    required String phone,
    required String position,
    required String image,
  }) async {
    final user = UserData(
      uid: uid,
      image: image,
      name: name,
      email: email,
      phone: phone,
      position: position,
      createdAt: DateTime.now(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(uid)
          .withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromMap(
              snapshot.data()!,
            ),
            toFirestore: (user, _) => user.toMap(),
          )
          .set(user);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String position,
    required Uint8List? file,
  }) async {
    try {
      if (file == null) {
        return left('image is required');
      }


      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = user.user!.uid;

      final image = await uploadImage(file, 'images/user/$uid');

      await createUser(
        uid: uid,
        image: image,
        name: name,
        email: user.user!.email!,
        phone: phone,
        position: position,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return left('The account already exists for that email.');
      }
    } catch (e) {
      return left(e.toString());
    }
    return right(unit);
  }

  @override
  Future<Either<String, Unit>> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for that user.');
      }
    } catch (e) {
      return left(e.toString());
    }
    return right(unit);
  }
}
