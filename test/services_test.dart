import 'package:flutter_api_with_bloc/api/service_api.dart';
import 'package:flutter_api_with_bloc/model/universities_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchUniversities', () {
    test('returns an Universities if the http call completes successfully', () async {
      final client = UniversitiesService();

      // Use Mockito to return a successful response when it calls the
      when(http.get(Uri.parse('http://universities.hipolabs.com/search?country=Jordan')))
          .thenAnswer((_) async =>
          http.Response('{"country": "Jordan", "name": "Arab Academy for Banking and Financial Sciences", "domains": ["aabfs.org"], "alpha_two_code": "JO", "state-province": null, "web_pages": ["http://www.aabfs.org/"]}', 200));

      expect(await client.getUniversities(), isA<UniversitiesModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = UniversitiesService();

      // Use Mockito to return an unsuccessful response when it calls the
      when(http
          .get(Uri.parse('http://universities.hipolabs.com/search?country=Jordan')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(client.getUniversities(), throwsException);
    });
  });
}