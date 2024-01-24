import 'package:go_rider/app/helper/local_state_helper.dart';

class SignUpState {
  LoadingState? loadingState;
  String? signUpMessage;

  SignUpState({
    this.loadingState = LoadingState.loadLocal,
    this.signUpMessage = '',
  });

  SignUpState copyWith({LoadingState? loadingState, String? signUpMessage}) =>
      SignUpState(
        loadingState: loadingState ?? this.loadingState,
        signUpMessage: signUpMessage ?? this.signUpMessage,
      );

  List<Object?> get props => [loadingState, signUpMessage];
}
