import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../main.dart';
import '../cubit/auth_cubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  void listenForCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Otp Screen'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.otpStatus == OtpStatus.success) {
              Navigator.pushReplacementNamed(context, Routes.feeds);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Login Success')));
            }
            if (state.otpStatus == OtpStatus.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                20.h,
                PinFieldAutoFill(
                  decoration: BoxLooseDecoration(
                    gapSpace: 20,
                    errorTextStyle: const TextStyle(color: Colors.red),
                    strokeColorBuilder: const FixedColorBuilder(
                      AppColors.greyColor,
                    ),
                    bgColorBuilder: const FixedColorBuilder(
                      AppColors.greyColor,
                    ),
                    textStyle: const TextStyle(
                      color: AppColors.textGreyColor,
                      fontSize: 24,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  currentCode: otpCode,
                  onCodeSubmitted: (String code) {
                    otpCode = code;
                  },
                  onCodeChanged: (String? code) async {
                    otpCode = code ?? '';
                    logger.i(code);
                    if ((code ?? '').length == 6) {
                      await context.read<AuthCubit>().loginWithPhone(
                        verificationId: widget.verificationId,
                        smsCode: otpCode,
                        name: 'mina zakaria'
                      );
                      otpCode = '';
                    }
                  },
                  codeLength: 6,
                  cursor: Cursor(
                    width: 2,
                    height: 20,
                    color: AppColors.textGreyColor,
                  ),
                ),
                if (state.otpStatus == OtpStatus.loading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black26,
                      width: double.infinity,
                      height: double.infinity,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
