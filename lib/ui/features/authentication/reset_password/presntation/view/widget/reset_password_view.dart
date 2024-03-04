import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  static final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: loginBloc,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    AppStrings.resetPwd,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor),
                  ),
                  SizedBox(height: 10.h),
                  AppTextField(
                    hintText: 'Enter Email',
                    controller: emailController,
                    enableInteractiveSelection: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Platform.isAndroid
                        ? const Icon(Icons.mail)
                        : const Icon(CupertinoIcons.mail),
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field is required';
                      } else if (!EmailValidator.validate(val)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  PrimaryButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');

                        //   loginBloc.add(Login(
                        //       context: context,
                        //       email: emailController.text.trim(),
                        //       password: passwordController.text.trim()));
                      }
                    },
                    label: 'Reset Password',
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.greyColor),
                          children: [
                            TextSpan(
                                text: ' Sign in',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go('/login');
                                  },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor,
                                      decoration: TextDecoration.underline,
                                    ))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
