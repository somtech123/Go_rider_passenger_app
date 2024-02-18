import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_bloc.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_bloc_state.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_event.dart';
import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';

// ignore: must_be_immutable
class AccountLoadedStateView extends StatefulWidget {
  AccountLoadedStateView({super.key, required this.state});

  AccountBlocState state;

  static final formKey = GlobalKey<FormState>();

  @override
  State<AccountLoadedStateView> createState() => _AccountLoadedStateViewState();
}

class _AccountLoadedStateViewState extends State<AccountLoadedStateView> {
  TextEditingController? nameCtr;

  @override
  void initState() {
    super.initState();
    nameCtr = TextEditingController(text: widget.state.userModel!.username);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.h),
        child: Form(
          key: AccountLoadedStateView.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: widget.state.selectedImage == null
                    ? CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            widget.state.userModel!.profileImage ??
                                AppStrings.dummyProfilePicture),
                        child: ClipOval(
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                height: 30.h,
                                child: GestureDetector(
                                  onTap: () =>
                                      BlocProvider.of<AccountBloc>(context)
                                          .add(SelectProfileImage()),
                                  child: Container(
                                    height: 20.h,
                                    width: 30.w,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: const Center(
                                      child: Icon(Icons.photo_camera,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : _imageWidget(context, file: widget.state.selectedImage!),
              ),
              SizedBox(height: 20.h),
              Text(
                AppStrings.fullName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.darkColor),
              ),
              SizedBox(height: 10.h),
              AppTextField(
                hintText: 'User Name',
                controller: nameCtr,
                enableInteractiveSelection: false,
                prefixIcon: Platform.isIOS
                    ? const Icon(CupertinoIcons.person)
                    : const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                ],
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'This Field is required';
                  }
                  return null;
                },
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).unfocus();
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                onPressed: () {
                  if (AccountLoadedStateView.formKey.currentState!.validate()) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');

                    BlocProvider.of<AccountBloc>(context)
                        .add(UpdateProfile(username: nameCtr!.text));
                  }
                },
                label: 'Update Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget(BuildContext context, {required File file}) {
    return CircleAvatar(
      radius: 50.r,
      backgroundColor: Colors.transparent,
      backgroundImage: FileImage(file),
      child: ClipOval(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: 30.h,
              child: GestureDetector(
                onTap: () => BlocProvider.of<AccountBloc>(context)
                    .add(SelectProfileImage()),
                child: Container(
                  height: 20.h,
                  width: 30.w,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                    child: Icon(Icons.photo_camera, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
