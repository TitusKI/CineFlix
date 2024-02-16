class ItemModel {
  late int _page;
  late int _total_results;
  late int _total_pages;
  List<_Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];
    List<_Result> temp = [];
    for(_page = 1; _page <= _total_pages; _page ++){
      _page = _page++;
       for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][
          i]); // It only responses one result from the list with specific index
      temp.add(result); // add that result of specific index to the temp list
    }

    }
   
    _results = temp;
  }

  List<_Result> get results => _results;
  int get total_pages => _total_pages;
  int get total_results => _total_results;
  int get page => _page;
}

class _Result {
  late int _vote_count;
  late int _id;
  late bool _video;
  late double _vote_average;
  late String _title;
  late double _popularity;
  late String _poster_path;
  late String _original_language;
  late String _original_title;
  late List<int> _genre_ids;
  late String _backdrop_path;
  late bool _adult;
  late String _overview;
  late String _release_date;
  _Result(result) {
    _vote_count = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _vote_average = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _poster_path = result['poster_path'];
    _original_language = result['original_language'];
    _original_title = result['original_title'];
    _genre_ids = <int>[];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
    _backdrop_path = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    _release_date = result['release_date'];
  }
  String get release_date => _release_date;

  String get overview => _overview;

  bool get adult => _adult;

  String get backdrop_path => _backdrop_path;

  List<int> get genre_ids => _genre_ids;

  String get original_title => _original_title;

  String get original_language => _original_language;

  String get poster_path => _poster_path;

  double get popularity => _popularity;

  String get title => _title;

  double get vote_average => _vote_average;

  bool get video => _video;

  int get id => _id;

  int get vote_count => _vote_count;
}
