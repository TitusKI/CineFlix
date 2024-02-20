import 'package:http/http.dart' show Client;


class PeopleApiProvider{
  Client client = Client();
  final _apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
  final _apiUrl = 'https://api.themoviedb.org/3/person';
 
}