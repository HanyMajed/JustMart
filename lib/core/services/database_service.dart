import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';

abstract class DatabaseService {
  Future<void> addData({required String path, required Map<String, dynamic> data});

  Future<Map<String, dynamic>> getData({required String path, required String documentId});
}
