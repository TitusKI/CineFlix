import '../models/trailer_model.dart';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class MoviesApiProvider {
  Client client = Client();
  final _apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
  final _apiUrl = 'https://api.themoviedb.org/3/movie';
  Future<ItemModel?> fetchMovieList() async {
    print('entered');
    final response =
        await client.get(Uri.parse('$_apiUrl/popular?api_key=$_apiKey'));
    print(response.body.toString());
    final parsedJsonDecode = json.decode(response
        .body); // We have to Decode the json file before using with fromJson
    if (response.statusCode ==
        200) // indicates that if the request is successful
    {
      return ItemModel.fromJson(parsedJsonDecode);
    } else {
      throw Exception('Failed to load Post');
    }
  }

  Future<ItemModel?> fetchTopRated() async {
    print('Entered'); // Checking the method fetchTopRated
    final response =
        await client.get(Uri.parse('$_apiUrl/top_rated?api_key=$_apiKey'));
    print(response.body.toString()); // printing the json file as it is

    final parsedJsonDecode = json.decode(response.body);
    if (response.statusCode == 200) {
      return ItemModel.fromJson(parsedJsonDecode);
    } else {
      throw Exception('Failed to load the post');
    }
  }

  Future<ItemModel?> fetchNowPlaying() async {
    print('Now Playing Entered');
    final response =
        await client.get(Uri.parse('$_apiUrl/now_playing?api_key=$_apiKey'));
    print(response.body.toString());
    final parsedJsonDecode = json.decode(response.body);
    if (response.statusCode == 200) {
      return ItemModel.fromJson(parsedJsonDecode);
    } else {
      throw Exception('Failed to load the post');
    }
  }

  Future<ItemModel?> fetchUpcoming() async {
    print('Upcoming');
    final response =
        await client.get(Uri.parse('$_apiUrl/upcoming?api_key=$_apiKey'));
    print(response.body.toString());
    final parsedJsonDecode = json.decode(response.body);
    if (response.statusCode == 200) {
      return ItemModel.fromJson(parsedJsonDecode);
    } else {
      throw Exception('Failed to load the post');
    }
  }

  Future<TrailerModel?> fetchTrailer(int movieId) async {
    final response = await client
        .get(Uri.parse('$_apiUrl/$movieId/videos?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
