import 'package:equatable/equatable.dart';
import 'package:flutter_api_with_bloc/model/universities_model.dart';

//Here to fetch and display API data I will create the cases below.
abstract class UniversitiesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//While calling the API
class UniversitiesLoadingState extends UniversitiesState {}

//Before calling the API
class UniversitiesInitialState extends UniversitiesState {}

//After fetch the data from API
class UniversitiesLoadedState extends UniversitiesState {
  final List<UniversitiesModel> universities;
  UniversitiesLoadedState({required this.universities});
}

//If we receive error on Data
class UniversitiesListErrorState extends UniversitiesState {
  final error;
  UniversitiesListErrorState({this.error});
}
