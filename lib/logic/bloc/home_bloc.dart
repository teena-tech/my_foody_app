import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_swissy/data/models/property_model.dart';
import 'package:online_swissy/data/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final properties = await repository.getProperties();
        emit(HomeLoaded(properties));
      } catch (e) {
        emit(HomeError("Failed to load properties"));
      }
    });
  }
}
