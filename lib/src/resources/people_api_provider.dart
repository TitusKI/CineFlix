import 'dart:convert';

import 'package:cineflix/src/models/people_model.dart';
import 'package:http/http.dart';

class PeopleApiProvider {
  Client client = Client();
  final _apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
  final _apiUrl = "https://api.themoviedb.org/3/";

  Future<List<Person>> fetchPeople(int id, int mediaType) async {
    final response = await client.get(Uri.parse(
        '$_apiUrl${mediaType == 1 ? "movie" : "tv"}/$id/credits?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      People people = People.fromJson(json);

      return people.people.sublist(0, people.people.length > 10 ? 10 : null);
    } else {
      throw Exception('Failed to fetch people');
    }
  }
}
