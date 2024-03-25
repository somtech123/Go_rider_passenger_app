import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/view/widget/social_button_widget.dart';

import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('login');

class LoginBodyView extends StatefulWidget {
  const LoginBodyView({super.key});

  @override
  State<LoginBodyView> createState() => _LoginBodyViewState();
}

class _LoginBodyViewState extends State<LoginBodyView> {
  static final formKey = GlobalKey<FormState>();

  late FocusNode passwordNode;
  late FocusNode emailNode;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final alphaRegex = RegExp(r'[a-zA-Z]');

  @override
  void initState() {
    passwordNode = FocusNode();
    emailNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();

    passwordNode.dispose();
    emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: loginBloc,
      builder: (context, state) {
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.h),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      AppStrings.enterEmail,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.darkColor),
                    ),
                    SizedBox(height: 10.h),
                    AppTextField(
                      hintText: 'Enter Email',
                      controller: emailController,
                      enableInteractiveSelection: false,
                      focusNode: emailNode,
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
                    SizedBox(height: 20.h),
                    Text(
                      AppStrings.enterPassword,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.darkColor),
                    ),
                    SizedBox(height: 10.h),
                    AppTextField(
                        hintText: 'Password',
                        prefixIcon: Platform.isIOS
                            ? const Icon(CupertinoIcons.lock)
                            : const Icon(Icons.lock),
                        obscureText: state.isVisible!,
                        enableInteractiveSelection: false,
                        controller: passwordController,
                        focusNode: passwordNode,
                        suffixIcon: Platform.isIOS
                            ? IconButton(
                                onPressed: () {
                                  loginBloc.add(ObsureText());
                                },
                                icon: state.isVisible!
                                    ? const Icon(CupertinoIcons.eye)
                                    : const Icon(CupertinoIcons.eye_slash),
                              )
                            : IconButton(
                                onPressed: () {
                                  loginBloc.add(ObsureText());
                                },
                                icon: state.isVisible!
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) {
                          FocusScope.of(context).unfocus();
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'This Field is required';
                          } else if (!val.contains(alphaRegex)) {
                            return "Password should contain numbers and alphabets";
                          }
                          return null;
                        }),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topRight,
                      child: RichText(
                          text: TextSpan(
                              text: AppStrings.forgetPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.greyColor,
                                  ),
                              children: [
                            TextSpan(
                              text: ' Reset',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push('/passwordReset');
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                            )
                          ])),
                    ),
                    SizedBox(height: 20.h),
                    PrimaryButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          log.w('Loggin user in ');
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');

                          loginBloc.add(Login(
                              context: context,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim()));
                        }
                      },
                      label: AppStrings.siginIN,
                    ),
                    SizedBox(height: 25.h),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Text(
                          AppStrings.connect,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.greyColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    socilaButton(
                      context,
                      ontap: () async => loginBloc.add(GoogleSignin(context)),
                      text: AppStrings.googleConnect,
                      leading: Image.asset(
                        'assets/images/google_icon.png',
                        height: 20.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    socilaButton(context, ontap: () {
                      log.w('facebook clicked');
                    },
                        text: AppStrings.facebookConnect,
                        leading: SvgPicture.asset(
                          'assets/svgs/facebook.svg',
                        )),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            text: "Don't have an account?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.greyColor),
                            children: [
                              TextSpan(
                                  text: ' Sign up',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      log.w('navigate to sign up screen');
                                      context.push('/signUp');
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
                    SizedBox(height: 30.h)
                  ],
                ),
              ),
            ));
      },
    );
  }
}
