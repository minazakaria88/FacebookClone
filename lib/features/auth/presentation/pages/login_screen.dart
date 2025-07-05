import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:app_factory/core/helpers/validate_inpus_class.dart';
import 'package:app_factory/core/routes/routes.dart';
import 'package:app_factory/core/utils/app_styles.dart';
import 'package:app_factory/core/widget/my_button.dart';
import 'package:app_factory/core/widget/my_text_form.dart';
import 'package:app_factory/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.loginStatus == LoginStatus.success) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Login Success')));
              Navigator.pushReplacementNamed(context, Routes.feeds);
            }
            if (state.loginStatus == LoginStatus.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    100.h,
                    const Text(
                      'Welcome Back',
                      style: AppStyles.bold28BlackTextColor,
                    ),
                    20.h,
                    MyTextForm(
                      controller: email,
                      hint: 'Email',
                      validator: (String? value) {
                        return ValidationClass.validateEmail(value);
                      },
                    ),
                    20.h,
                    MyTextForm(
                      controller: password,
                      hint: 'Password',
                      validator: (String? value) {
                        return ValidationClass.validateText(
                          value,
                          'Please Enter A Valid Password',
                        );
                      },
                    ),
                    30.h,
                    state.loginStatus == LoginStatus.loading
                        ? const CircularProgressIndicator()
                        : MyButton(
                            text: 'Sign In',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                  email: email.text,
                                  password: password.text,
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
