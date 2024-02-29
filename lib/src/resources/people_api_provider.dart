// import 'dart:convert';

// import 'package:cineflix/src/models/item_model.dart';
// import 'package:http/http.dart' show Client;

// import '../models/people_model.dart';


// class PeopleApiProvider{
//   Client client = Client();
//   final _apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
//   final _apiUrl = 'https://api.themoviedb.org/3/person';
//   Future<PeopleModel?> fetchPopularPeople() async{
//     print('Famous Entered');
//     final response = await client.get(Uri.parse('$_apiUrl/popular?api_key=$_apiKey'));
//     print(response.body.toString());
//     final parsedJson = json.decode(response.body);
//     if(response.statusCode == 200){
//       return PeopleModel.fromJson(parsedJson);
//     }
//     else{
//       throw Exception('Failed to load the post');
//     }
    
//   }
// }