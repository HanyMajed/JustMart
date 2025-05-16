import 'package:dartz/dartz.dart';
import 'package:just_mart/core/errors/failures.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name, String role, String phoneNumber);
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(String email, String password);
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uId});
}
