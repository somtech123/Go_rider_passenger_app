// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_rider/app/helper/image_helper.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/firebase_services/firebase_repository.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_bloc_state.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_event.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';

var log = getLogger('Account_bloc');

class AccountBloc extends Bloc<AccountBlocEvent, AccountBlocState> {
  AccountBloc()
      : super(AccountBlocState(
          loadingState: LoadingState.initial,
          selectedImage: null,
        )) {
    on<SelectProfileImage>((event, emit) async {
      await seleectGalleryImage();
    });

    on<GetAccountDetail>((event, emit) async {
      await getUserDetail();
    });

    on<UpdateProfile>((event, emit) async {
      await updateProfile(event.username);
    });
  }

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getUserDetail() async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, userModel: UserModel()));

    try {
      DocumentSnapshot<Map<String, dynamic>> snap = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();

      UserModel userModel = UserModel.fromJson(snap.data()!);

      log.w(userModel);

      emit(state.copyWith(
          loadingState: LoadingState.loaded, userModel: userModel));
    } catch (e) {
      log.d(e);

      emit(state.copyWith(
          loadingState: LoadingState.error, userModel: UserModel()));
    }
  }

  seleectGalleryImage() async {
    var file = await ImageHelper.getFromGallery(false);

    if (file != null) {
      emit(state.copyWith(selectedImage: file));

      String photo = await _firebaseRepository.updateProfilePhoto(file);
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .update({'profileImage': photo});
    } else {}
  }

  updateProfile(String name) async {
    EasyLoading.show(status: 'loading...');

    emit(state.copyWith(uploadState: LoadingState.loading));

    await _firebaseRepository.updateProfile(payload: {'userName': name});

    EasyLoading.showSuccess('Successfully Update Profile');
    EasyLoading.dismiss();

    emit(state.copyWith(uploadState: LoadingState.loaded));
  }
}
