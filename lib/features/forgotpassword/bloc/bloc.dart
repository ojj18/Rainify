import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/features/forgotpassword/bloc/bloc_event.dart';
import 'package:rainify/features/forgotpassword/bloc/bloc_state.dart';
import 'package:rainify/features/forgotpassword/data/reprository/forgot_password_repo.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordRepository forgotPasswordRepository;
  ForgotPasswordBloc(this.forgotPasswordRepository)
    : super((ForgotPasswordInitialState())) {
    on<PasswordResetEvent>((event, emit) async {
      emit(ForgotPasswordLoadingState());
      try {
        await forgotPasswordRepository.passwordResetMethod(email: event.email);
        emit(ForgotPasswordSuccessState());
      } catch (e) {
        emit(ForgotPasswordErrorState(errorMessage: e.toString()));
      }
    });
  }
}
