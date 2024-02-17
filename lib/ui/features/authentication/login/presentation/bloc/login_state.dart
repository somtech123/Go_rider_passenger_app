import 'package:go_rider/app/helper/local_state_helper.dart';

class LoginState {
  LoadingState? loadingState;
  bool? isVisible;

  LoginState({
    this.loadingState = LoadingState.initial,
    this.isVisible = true,
  });

  LoginState copyWith({LoadingState? loadingState, bool? isVisible}) =>
      LoginState(
          loadingState: loadingState ?? this.loadingState,
          isVisible: isVisible ?? this.isVisible);

  List<Object?> get props => [loadingState, isVisible];
}
