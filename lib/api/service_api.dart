import 'package:flutter_api_with_bloc/model/universities_model.dart';
import 'package:http/http.dart' as http;

// Service Layer to connect server and fetch data from server.
//I am calling the api with http get method and fetch http response and pass it to model class to create list of universities data.
abstract class ServiceApi {
  Future<List<UniversitiesModel>> getUniversities();
}

class UniversitiesService extends ServiceApi {
  String baseUrl = "http://universities.hipolabs.com";
  @override
  Future<List<UniversitiesModel>> getUniversities() async {
    try {
      var uri = Uri.parse("$baseUrl/search?country=Jordan");
      var response =
          await http.get(uri, headers: {"ContentType": "application/json"});
      var universitiesList = universitiesFromJson(response.body);

      return universitiesList;
    } catch (e) {
      return List<UniversitiesModel>.empty();
    }
  }
}
