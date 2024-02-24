class PeopleModel {
  late int _page;
  late int _total_pages;
  late int _total_results;
  List<_Result> _results = [];
  PeopleModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_pages = parsedJson['total_pages'];
    _total_results = parsedJson['total_results'];
    List<_Result> temp = [];
    for(int i = 0; i < parsedJson['results'].length; i++){
      _Result result = _Result(parsedJson['results'][i]);
    }
  }
}

class _Result {
  late bool _adult;
  late int _gender;
  late int _id;
  late String _known_for_department;
  late String _name;
  late String _original_name;
  late double _popularity;
  late String _profile_path;
  late List<_KnownForResult> _knownForResult = [];

  _Result(result) {
    _adult = result['adult'];
    _gender = result['gender'];
    _id = result['id'];
    _known_for_department = result['known_for_department'];
    _name = result['name'];
    _original_name = result['original_name'];
    _popularity = result['popularity'];
    _profile_path = result['profile_path'];
  }
}

class _KnownForResult {
  late String _name;
  late String _original_name;
  late String _media_type;
  late String _first_air_date;
  late int    _vote_count;
  late int    _id;
  late List<String> _origin_country;
  late double _vote_average;
 
  late double _popularity;
  late String _poster_path;
  late String _original_language;

late List<int> _genre_ids;
  late String _backdrop_path;
  late bool   _adult;
  late String _overview;

  _KnownForResult(knownForResult){
    _name = knownForResult['name'];
_original_name = knownForResult['original_name'];
_media_type = knownForResult['media_type'];
_first_air_date = knownForResult['first_air_date'];
_vote_count = knownForResult['vote_count'];
_id = knownForResult['id'];

_vote_average = knownForResult['vote_average'];

_popularity = knownForResult['popularity'];
_poster_path = knownForResult['poster_path'];
_original_language = knownForResult['original_language'];

 _genre_ids = <int>[];
    for (int i = 0; i < knownForResult['genre_ids'].length; i++) {
      _genre_ids.add(knownForResult['genre_ids'][i]);
    }
_backdrop_path = knownForResult['backdrop_path'];
_adult = knownForResult['adult'];
_overview = knownForResult['overview'];
_origin_country = <String>[];
for (int i = 0; i < knownForResult['origin_country'].length; i++){
  _origin_country.add(knownForResult['origin_country'][i]);
}

  }
}
