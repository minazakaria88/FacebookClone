import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:app_factory/core/helpers/validate_inpus_class.dart';
import 'package:app_factory/core/routes/routes.dart';
import 'package:app_factory/core/utils/app_colors.dart';
import 'package:app_factory/core/utils/app_styles.dart';
import 'package:app_factory/core/widget/my_button.dart';
import 'package:app_factory/core/widget/my_text_form.dart';
import 'package:app_factory/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    userName.dispose();
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
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Login Success')));
                }
                if (state.registerStatus == RegisterStatus.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
            ),

            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) => previous
                  .registerWithGoogleStatus != current.registerWithGoogleStatus,
              listener: (context, state) {
                if (state.registerWithGoogleStatus ==
                    RegisterWithGoogleStatus.success) {
                  Navigator.pushReplacementNamed(context, Routes.feeds);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Register Success')));
                }
                if (state.registerWithGoogleStatus ==
                    RegisterWithGoogleStatus.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
            ),

          ],
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          80.h,
                          const Text(
                            'Create an account',
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
                                'PLease Enter A Valid Password',
                              );
                            },
                          ),
                          20.h,
                          MyTextForm(
                            controller: userName,
                            hint: 'Username',
                            validator: (String? value) {
                              return ValidationClass.validateText(
                                value,
                                'PLease Enter A Valid Username',
                              );
                            },
                          ),
                          30.h,
                          state.registerStatus == RegisterStatus.loading
                              ? const CircularProgressIndicator()
                              : MyButton(
                                  text: 'Sign Up',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().register(
                                        email: email.text,
                                        password: password.text,
                                        name: userName.text,
                                      );
                                    }
                                  },
                                ),
                          20.h,
                          state.registerWithGoogleStatus ==
                                  RegisterWithGoogleStatus.loading
                              ? const CircularProgressIndicator()
                              : MyButton(
                                  text: 'Sign Up With Google',
                                  onTap: () {
                                    context
                                        .read<AuthCubit>()
                                        .registerWithGoogle();
                                  },
                                  textColor: AppColors.blackTextColor,
                                  color: AppColors.greyColor,
                                ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: AppStyles.regular14textgreyColor,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(Routes.login);
                                },
                                child: const Text(
                                  'Log in',
                                  style: AppStyles.regular14textgreyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
