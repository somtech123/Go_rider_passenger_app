import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/history/data/history_model.dart';

class HistoryBlocState {
  LoadingState? loadingState;

  List<HistoryModel>? historyModel;

  HistoryBlocState({
    this.loadingState = LoadingState.initial,
    this.historyModel,
  });

  HistoryBlocState copyWith(
          {LoadingState? loadingState, List<HistoryModel>? historyModel}) =>
      HistoryBlocState(
        loadingState: loadingState ?? this.loadingState,
        historyModel: historyModel ?? this.historyModel,
      );

  List<Object?> get props => [
        loadingState,
        historyModel,
      ];
}
