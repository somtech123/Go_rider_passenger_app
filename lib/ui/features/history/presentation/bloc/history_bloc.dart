// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/firebase_services/firebase_repository.dart';
import 'package:go_rider/ui/features/history/data/history_model.dart';
import 'package:go_rider/ui/features/history/presentation/bloc/history_bloc_event.dart';
import 'package:go_rider/ui/features/history/presentation/bloc/history_bloc_state.dart';

var log = getLogger('History_bloc');

class HistoryBloc extends Bloc<HistorylocEvent, HistoryBlocState> {
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  HistoryBloc() : super(HistoryBlocState()) {
    on<GetRideHistory>((event, emit) async {
      getRiderHistory();
    });
  }

  getRiderHistory() async {
    emit(state.copyWith(loadingState: LoadingState.loading));

    List<HistoryModel> data = await _firebaseRepository.getRideHistory();

    emit(state.copyWith(historyModel: data, loadingState: LoadingState.loaded));
  }
}
