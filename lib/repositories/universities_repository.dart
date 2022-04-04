import 'package:flutter_api_with_bloc/api/service_api.dart';
import 'package:flutter_api_with_bloc/model/universities_model.dart';
class UniversitiesRepository{

  Future<List<UniversitiesModel>>getUniversitiesList(){

    return UniversitiesService().getUniversities();
  }
}