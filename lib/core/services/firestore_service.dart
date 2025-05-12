import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_mart/core/services/database_service.dart';

class FireStoreService implements DatabaseService {
  final FirebaseFirestore firestore;

  FireStoreService() : firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({required String path, required Map<String, dynamic> data}) async {
    try {
      final uId = data['uId'];
      if (uId == null) throw Exception('User ID is required');

      await firestore.collection(path).doc(uId).set(data);
    } catch (e) {
      log('Error in FireStoreService.addData: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getData({required String path, required String documentId}) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.data() as Map<String, dynamic>;
  }
}
