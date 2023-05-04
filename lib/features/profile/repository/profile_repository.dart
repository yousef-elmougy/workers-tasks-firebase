import 'package:dartz/dartz.dart';

import '../../../lib_exports.dart';

abstract class ProfileRepository {
  const ProfileRepository();
  Future<Either<String, UserData>> getUserProfile();
  Future<Either<String, Unit>> updateUserProfile({
    required Uint8List? file,
    required String name,
    required String phone,
    required UserData user,
  });
  Future<Either<String, Unit>> updateUserPassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<Either<String, Unit>> deleteUserProfile();
}
