import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:just_mart/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exeption in firebaseAuthService.createUsingEmailAndPassword ${e.toString()}");
      if (e.code == 'weak-password') {
        throw CustomException(message: "الرقم السري ضعيف جداً");
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'لقد تم تسجيل هذا البريد بالفعل مسبقاً');
      } else if (e.code == "network-request-failed") {
        throw CustomException(message: "تأكد من إتصالك بالانترنت");
      } else {
        throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
      }
    } catch (e) {
      log("Exeption in firebaseAuthService.createUsingEmailAndPassword ${e.toString()}");

      throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
    }
  }

  Future<User> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exeption in firebaseAuthService.createUsingEmailAndPassword ${e.toString()}");
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'البريد الالكتروني غير صحيح');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'كلمة المرور غير صحيحة');
      } else if (e.code == "network-request-failed") {
        throw CustomException(message: "تأكد من إتصالك بالانترنت");
      } else {
        throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
      }
    } catch (e) {
      log("Exeption in firebaseAuthService.createUsingEmailAndPassword ${e.toString()}");
      throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
    }
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }
}
