import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
// import '../models/trailer_model.dart';

class TvShowsApiProvider {
  Client client = Client();
  final _apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
  final _apiUrl = 'https://api.themoviedb.org/3/tv';
  Future<ItemModel?> fetchPopular() async {
    final response =
        await client.get(Uri.parse('$_apiUrl/popular?api_key=$_apiKey'));
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
    final response =
        await client.get(Uri.parse('$_apiUrl/top_rated?api_key=$_apiKey'));
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

  Future<ItemModel?> fetchAiringToday() async {
    final response =
        await client.get(Uri.parse('$_apiUrl/airing_today?api_key=$_apiKey'));
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

  Future<ItemModel?> fetchOnTv() async {
    final response =
        await client.get(Uri.parse('$_apiUrl/on_the_air?api_key=$_apiKey'));
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

  // Trailer for tv shows for code below
}
