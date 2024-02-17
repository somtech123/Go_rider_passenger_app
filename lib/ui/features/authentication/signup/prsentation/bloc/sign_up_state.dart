import 'package:go_rider/app/helper/local_state_helper.dart';

class SignUpState {
  LoadingState? loadingState;
  String? signUpMessage;
  bool? isVisible;

  SignUpState({
    this.loadingState = LoadingState.loadLocal,
    this.signUpMessage = '',
    this.isVisible = true,
  });

  SignUpState copyWith(
          {LoadingState? loadingState,
          String? signUpMessage,
          bool? isVisible}) =>
      SignUpState(
          loadingState: loadingState ?? this.loadingState,
          signUpMessage: signUpMessage ?? this.signUpMessage,
          isVisible: isVisible ?? this.isVisible);

  List<Object?> get props => [loadingState, signUpMessage, isVisible];
}
