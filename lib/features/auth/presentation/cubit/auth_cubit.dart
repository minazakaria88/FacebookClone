import 'dart:ffi';

import 'package:app_factory/features/auth/data/repositories/auth_repo.dart';
import 'package:app_factory/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthState());
  final AuthRepository authRepository;

  void login({required String email, required String password}) async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      await authRepository.login(email: email, password: password);
      emit(state.copyWith(loginStatus: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(state.copyWith(registerStatus: RegisterStatus.loading));
      await authRepository.register(
        email: email,
        password: password,
        name: name,
      );
      emit(state.copyWith(registerStatus: RegisterStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          registerStatus: RegisterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void registerWithGoogle() async {
    try {
      emit(
        state.copyWith(
          registerWithGoogleStatus: RegisterWithGoogleStatus.loading,
        ),
      );
      await authRepository.signInWithGoogle();
      emit(
        state.copyWith(
          registerWithGoogleStatus: RegisterWithGoogleStatus.success,
        ),
      );
    } catch (e) {
      logger.i(e.toString());
      emit(
        state.copyWith(
          registerWithGoogleStatus: RegisterWithGoogleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void verifyPhoneNumber({required String phoneNumber}) async {
    try {
      emit(state.copyWith(loginWithPhoneStatus: LoginWithPhoneStatus.loading));
      final verificationId = await authRepository.verifyPhoneNumber(
        phoneNumber: phoneNumber,
      );
      emit(
        state.copyWith(
          loginWithPhoneStatus: LoginWithPhoneStatus.success,
          verificationId: verificationId,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loginWithPhoneStatus: LoginWithPhoneStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loginWithPhone({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      emit(state.copyWith(otpStatus: OtpStatus.loading));
      await authRepository.signInWithPhoneNumber(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      emit(state.copyWith(otpStatus: OtpStatus.success));
    } catch (e) {
      emit(
        state.copyWith(otpStatus: OtpStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
