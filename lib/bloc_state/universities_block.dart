import 'dart:io';

import 'universities_state.dart';
import 'package:flutter_api_with_bloc/bloc_state/universities_events.dart';
import 'package:flutter_api_with_bloc/model/universities_model.dart';
import 'package:flutter_api_with_bloc/repositories/universities_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Every bloc will contains three class bloc, state and event.
class UniversitiesBloc extends Bloc<UniversitiesEvents, UniversitiesState> {
  final UniversitiesRepository universitiesRepository;
  late List<UniversitiesModel> listUniversities;
  UniversitiesBloc({required this.universitiesRepository})
      : super(UniversitiesInitialState());

  @override
  Stream<UniversitiesState> mapEventToState(UniversitiesEvents event) async* {
    switch (event) {
      case UniversitiesEvents.fetchUniversities:
        yield UniversitiesLoadingState();

        try {
          listUniversities = await universitiesRepository.getUniversitiesList();

          yield UniversitiesLoadedState(universities: listUniversities);
        } on SocketException {
          yield UniversitiesListErrorState(
            error: ('No Internet'),
          );
        } on HttpException {
          yield UniversitiesListErrorState(
            error: ('No Service'),
          );
        } on FormatException {
          yield UniversitiesListErrorState(
            error: ('No Format Exception'),
          );
        } catch (e) {
          print(e.toString());
          yield UniversitiesListErrorState(
            error: ('Un Known Error ${e.toString()}'),
          );
        }
        break;
    }
  }
}
