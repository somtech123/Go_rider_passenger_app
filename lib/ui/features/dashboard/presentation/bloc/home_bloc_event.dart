import 'package:equatable/equatable.dart';

abstract class HomePageBlocEvent extends Equatable {}

class RequestLocation extends HomePageBlocEvent {
  @override
  List<Object?> get props => [];
}
