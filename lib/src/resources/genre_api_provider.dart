import 'dart:convert';

import 'package:cineflix/src/models/genre_model.dart';
import 'package:http/http.dart';

class GenreApiProvider {
  Client client = Client();
  final _apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
  final _apiUrl = "https://api.themoviedb.org/3/genre/movie/list";

  // Future<Genre?> fetchGenreList() async {
  // print('fetching Genre');

  Future<List<Genre>> fetchGenres() async {
    final response = await client.get(Uri.parse('$_apiUrl?api_key=$_apiKey'));
    // final response = await http.get(Uri.https('api.example.com', '/genres'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      GenreResponse genreResponse = GenreResponse.fromJson(json);

      return genreResponse.genres;
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
  // // print(response.body.toString());
  // final parsedJsonDecode = json.decode(response
  //     .body); // We have to Decode the json file before using with fromJson

  // if (response.statusCode ==
  //     200) // indicates that if the request is successful
  // {
  //   print("fetch successfull");
  //   return Genre.fromJson(parsedJsonDecode);
  // } else {
  //   throw Exception('Failed to load Post');
  // }
}
// }
