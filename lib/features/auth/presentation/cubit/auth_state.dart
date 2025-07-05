part of 'auth_cubit.dart';

enum LoginStatus { initial, loading, success, error }

enum RegisterStatus { initial, loading, success, error }

enum RegisterWithGoogleStatus { initial, loading, success, error }

class AuthState extends Equatable {
  LoginStatus? loginStatus;
  RegisterStatus? registerStatus;
  RegisterWithGoogleStatus? registerWithGoogleStatus;
  String? errorMessage;
  AuthState({
    this.loginStatus,
    this.registerStatus,
    this.errorMessage,
    this.registerWithGoogleStatus,
  });

  AuthState copyWith({
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
    RegisterWithGoogleStatus? registerWithGoogleStatus,
    String? errorMessage,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      registerWithGoogleStatus:
          registerWithGoogleStatus ?? this.registerWithGoogleStatus,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    registerStatus,
    errorMessage,
    registerWithGoogleStatus,
  ];
}
