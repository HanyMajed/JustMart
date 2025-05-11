import 'package:bloc/bloc.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/auth/data/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;

  Future<void> signin(String email, String password) async {
    emit(SigninLoading());
    var result = await authRepo.signinWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(
        SigninSucess(userEntity: userEntity),
      ),
    );
  }
}
