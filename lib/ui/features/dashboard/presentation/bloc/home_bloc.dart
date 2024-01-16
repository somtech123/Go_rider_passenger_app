import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageState> {
  HomePageBloc() : super(HomePageState()) {}
}
