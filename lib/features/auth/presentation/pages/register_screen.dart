import 'package:app_factory/core/routes/routes.dart';
import 'package:app_factory/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/register_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    userName.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) =>
                  previous.registerStatus != current.registerStatus,
              listener: (context, state) {
                if (state.registerStatus == RegisterStatus.success) {
                  Navigator.pushReplacementNamed(context, Routes.feeds);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Success')),
                  );
                }
                if (state.registerStatus == RegisterStatus.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
            ),

            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) =>
                  previous.registerWithGoogleStatus !=
                  current.registerWithGoogleStatus,
              listener: (context, state) {
                if (state.registerWithGoogleStatus ==
                    RegisterWithGoogleStatus.success) {
                  Navigator.pushReplacementNamed(context, Routes.feeds);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Register Success')),
                  );
                }
                if (state.registerWithGoogleStatus ==
                    RegisterWithGoogleStatus.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
            ),

            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) =>
                  previous.loginWithPhoneStatus != current.loginWithPhoneStatus,
              listener: (context, state) {
                if (state.loginWithPhoneStatus ==
                    LoginWithPhoneStatus.success) {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.otp,
                    arguments: state.verificationId,
                  );
                }
                if (state.loginWithPhoneStatus == LoginWithPhoneStatus.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
            ),
          ],
          child: RegisterBody(
            formKey: formKey,
            email: email,
            password: password,
            userName: userName,
            phone: phone,
          ),
        ),
      ),
    );
  }
}

