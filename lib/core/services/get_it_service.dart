import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:just_mart/core/services/database_service.dart';
import 'package:just_mart/core/services/firebase_auth_service.dart';
import 'package:just_mart/core/services/firestore_service.dart';
import 'package:just_mart/features/auth/data/domain/repos/auth_repo.dart';
import 'package:just_mart/features/auth/data/repos/auth_repo_implementation.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());

  // Verify registrations
  final authService = getIt<FirebaseAuthService>();
  final dbService = getIt<DatabaseService>();
  log('DI Initialized - AuthService: ${authService.runtimeType}, DBService: ${dbService.runtimeType}');

  getIt.registerSingleton<AuthRepo>(AuthRepoImplementation(
    firebaseAuthService: authService,
    databaseService: dbService,
  ));
}
