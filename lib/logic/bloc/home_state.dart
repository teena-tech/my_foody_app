part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PropertyModel> properties;
  HomeLoaded(this.properties);

  @override
  List<Object> get props => [properties];
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);

  @override
  List<Object> get props => [message];
}
