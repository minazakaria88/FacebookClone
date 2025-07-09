part of 'auth_cubit.dart';

enum LoginStatus { initial, loading, success, error }

enum RegisterStatus { initial, loading, success, error }

enum RegisterWithGoogleStatus { initial, loading, success, error }

enum LoginWithPhoneStatus { initial, loading, success, error }


enum LoginWithFacebookStatus { initial, loading, success, error }


enum OtpStatus { initial, loading, success, error }

class AuthState extends Equatable {
  LoginStatus? loginStatus;
  RegisterStatus? registerStatus;
  RegisterWithGoogleStatus? registerWithGoogleStatus;
  String? errorMessage;
  LoginWithPhoneStatus? loginWithPhoneStatus;
  String ? verificationId;
  OtpStatus? otpStatus;
  LoginWithFacebookStatus? loginWithFacebookStatus;
  AuthState({
    this.loginStatus,
    this.registerStatus,
    this.errorMessage,
    this.registerWithGoogleStatus,
    this.loginWithPhoneStatus,
    this.verificationId,
    this.otpStatus,
    this.loginWithFacebookStatus
  });

  AuthState copyWith({
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
    RegisterWithGoogleStatus? registerWithGoogleStatus,
    String? errorMessage,
    LoginWithPhoneStatus? loginWithPhoneStatus,
    String? verificationId,
    OtpStatus? otpStatus,
    LoginWithFacebookStatus? loginWithFacebookStatus
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      registerWithGoogleStatus:
          registerWithGoogleStatus ?? this.registerWithGoogleStatus,
      loginWithPhoneStatus: loginWithPhoneStatus ?? this.loginWithPhoneStatus,
      verificationId: verificationId ?? this.verificationId,
      otpStatus: otpStatus ?? this.otpStatus,
      loginWithFacebookStatus: loginWithFacebookStatus ?? this.loginWithFacebookStatus
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    registerStatus,
    errorMessage,
    registerWithGoogleStatus,
    loginWithPhoneStatus,
    verificationId,
    otpStatus,
    loginWithFacebookStatus
  ];
}
