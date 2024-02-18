import 'dart:io';

import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';

class AccountBlocState {
  File? selectedImage;
  LoadingState? loadingState;
  LoadingState? uploadState;

  UserModel? userModel;

  AccountBlocState({
    this.loadingState = LoadingState.initial,
    this.selectedImage,
    this.uploadState = LoadingState.initial,
    this.userModel,
  });

  AccountBlocState copyWith(
          {File? selectedImage,
          LoadingState? loadingState,
          LoadingState? uploadState,
          UserModel? userModel}) =>
      AccountBlocState(
          selectedImage: selectedImage ?? this.selectedImage,
          loadingState: loadingState ?? this.loadingState,
          uploadState: uploadState ?? this.uploadState,
          userModel: userModel ?? this.userModel);

  List<Object?> get props =>
      [loadingState, uploadState, selectedImage, userModel];
}
