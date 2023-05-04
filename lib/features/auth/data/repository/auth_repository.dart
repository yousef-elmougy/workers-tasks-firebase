import 'dart:typed_data';

import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<Either<String, Unit>> register({
    required String email,
    required String name,
    required String password,
    required String phone,
    required String position,
    required Uint8List? file,
  });
  Future<Either<String, Unit>> createUser({
    required String uid,
    required String image,
    required String name,
    required String email,
    required String phone,
    required String position,
  });
  Future<Either<String, Unit>> login({
    required String email,
    required String password,
  });
}
