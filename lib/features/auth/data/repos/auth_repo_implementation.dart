import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_mart/core/errors/exceptions.dart';
import 'package:just_mart/core/errors/failures.dart';
import 'package:just_mart/core/services/database_service.dart';
import 'package:just_mart/core/services/firebase_auth_service.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/auth/data/domain/repos/auth_repo.dart';
import 'package:just_mart/features/auth/data/models/user_model.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  AuthRepoImplementation(
      {required this.databaseService, required this.firebaseAuthService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email,
      String password,
      String name,
      String role,
      String phoneNumber) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      UserEntity userFromFirebaseConstructor = UserModel.fromFirebaseUser(user);
      userFromFirebaseConstructor.role = role;
      userFromFirebaseConstructor.name = name;
      userFromFirebaseConstructor.phoneNumber = phoneNumber;

      await addUserData(user: userFromFirebaseConstructor);
      log("User created successfully: ${userFromFirebaseConstructor.email}, "
          "Phone: ${userFromFirebaseConstructor.phoneNumber}, "
          "Name: ${userFromFirebaseConstructor.name}, "
          "Role: ${userFromFirebaseConstructor.role}, "
          "UID: ${userFromFirebaseConstructor.uId}");
      return right(userFromFirebaseConstructor);
    } on CustomException catch (e) {
      if (user != null) {
        await user.delete();
      }
      return left(
        ServerFailure(message: e.message),
      );
    } catch (e) {
      if (user != null) {
        await user.delete();
      }
      log("Exception in AuthRepoImplementation.createUsingEmailAndPassword ${e.toString()}");
      return left(
        ServerFailure(
          message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      var userEntity = await getUserData(uId: user.uid);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(
        ServerFailure(message: e.message),
      );
    } catch (e) {
      log("Exception in AuthRepoImplementation.createUsingEmailAndPassword ${e.toString()}");
      return left(
        ServerFailure(
          message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً',
        ),
      );
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    try {
      await databaseService.addData(
          path: BackendEndpoints.addUserData, data: user.toMap());
    } catch (e) {
      log('Error saving user data: $e');
      rethrow;
    }
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoints.getUserData, documentId: uId);
    return UserModel.fromJson(userData);
  }
}

// the edits i made are : instead of returning usermodel.firebase constructor i saved that usermodel.firebase constructor
//in a new user entity and i have edited the role because the role will be sent from somewhere where i provide the role
//and then i have returned the new userfromfirebaseconstructor that i have created and edited the role so it contains 
//the role in it