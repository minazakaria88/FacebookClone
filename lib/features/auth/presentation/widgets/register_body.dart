import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/validate_inpus_class.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widget/my_button.dart';
import '../../../../core/widget/my_text_form.dart';
import '../cubit/auth_cubit.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.userName,
    required this.phone,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController userName;
  final TextEditingController phone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
                              context.read<AuthCubit>().registerWithGoogle();
                            },
                            textColor: AppColors.blackTextColor,
                            color: AppColors.greyColor,
                          ),
                    20.h,
                    state.loginWithPhoneStatus == LoginWithPhoneStatus.loading
                        ? const CircularProgressIndicator()
                        : MyButton(
                            text: 'Sign In With Phone',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<AuthCubit>(),
                                  child: LoginWithPhoneWidget(phone: phone),
                                ),
                              );
                            },
                          ),
                    20.h,
                    MyButton(text: 'login with facebook', onTap: () {
                      context.read<AuthCubit>().loginWithFacebook();
                    }),
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
    );
  }
}

class LoginWithPhoneWidget extends StatelessWidget {
  const LoginWithPhoneWidget({super.key, required this.phone});

  final TextEditingController phone;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter Your Phone Number'),
            20.h,
            MyTextForm(
              controller: phone,
              hint: 'Phone Number',
              validator: (String? value) {
                return ValidationClass.validateText(
                  value,
                  'PLease Enter A Valid Phone Number',
                );
              },
            ),
            20.h,
            MyButton(
              text: 'Login',
              onTap: () {
                context.read<AuthCubit>().verifyPhoneNumber(
                  phoneNumber: '+2${phone.text}',
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
