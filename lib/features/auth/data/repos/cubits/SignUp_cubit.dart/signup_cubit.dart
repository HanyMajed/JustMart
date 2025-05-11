import 'package:bloc/bloc.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/auth/data/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.authRepo}) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(String email, String password, String name, String role) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(email, password, name, role);
    result.fold(
      (failure) => emit(SignupFailure(message: failure.message)),
      (userEntity) => emit(
        SignupSucess(userentity: userEntity),
      ),
    );
  }
}
