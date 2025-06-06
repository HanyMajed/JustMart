import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_mart/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        throw CustomException(
            message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
      }
    } catch (e) {
      log("Exeption in firebaseAuthService.createUsingEmailAndPassword ${e.toString()}");

      throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user!;

      // Add email verification check
      if (!user.emailVerified) {
        throw CustomException(message: 'البريد الإلكتروني غير مفعل');
      }

      return user;
    } on FirebaseAuthException catch (e) {
      log("Firebase Error Code: ${e.code}");
      switch (e.code) {
        case 'invalid-credential':
          throw CustomException(
              message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة');
        case 'network-request-failed':
          throw CustomException(message: "تأكد من إتصالك بالانترنت");
        case 'invalid-email':
          throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة');
        // Add this new case

        case 'too-many-requests':
          throw CustomException(
              message:
                  'تم حظر هذا الجهاز مؤقتًا بسبب كثرة الطلبات. الرجاء المحاولة لاحقًا');
        default:
          throw CustomException(
              message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
      }
    } catch (e) {
      // Preserve existing CustomException
      if (e is CustomException) rethrow;
      log("General Error: $e");
      throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
    }
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log("Password Reset Error: ${e.code}");
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة');
        case 'user-not-found':
          throw CustomException(message: 'البريد الإلكتروني غير مسجل');
        case 'network-request-failed':
          throw CustomException(message: 'تأكد من الاتصال بالإنترنت');
        default:
          throw CustomException(message: 'فشل إرسال رابط إعادة التعيين');
      }
    }
  }
}
