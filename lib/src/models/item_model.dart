class ItemModel {
  late int _page;
  late int _total_results;
  late int _total_pages;
  List<_Result> _results = [];
  List<_Result> _similarTitles = [];

  // ignore: library_private_types_in_public_api

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];
    List<_Result> temp = [];
    // for(_page = 1; _page <= _total_pages; _page ++){
    //   _page = _page++;
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][
          i]); // It only responses one result from the list with specific index
      temp.add(result); // add that result of specific index to the temp list
    }

    // }

    _results = temp;
  }
  _Result? populateSimilarTitles(String clickedTitle) {
    _Result? clickedItem;

    // Find all items with the same title
    List<_Result> similarTitles =
        _results.where((result) => result.title == clickedTitle).toList();

    if (similarTitles.length == 1) {
      clickedItem = similarTitles[0];
    } else {
      clickedItem = null;
    }
    _similarTitles = similarTitles;
    return clickedItem;
  }

  void setResults(List<_Result> results) {
    _results = results;
  }

  //  populateSimilarTitles(String clickedTitle){
  //   List<_Result> similarTitles = _results.where((result) => result.title == clickedTitle).toList();
  //   _similarTitles = similarTitles;
  //    return _similarTitles;
  // }

  List<_Result> get results => _results;
  List<_Result> get similarTitles => _similarTitles;
  int get total_pages => _total_pages;
  int get total_results => _total_results;
  int get page => _page;
}

class _Result {
  // late int _vote_count;
  late int _id;
  // late bool _video;
  // late int _first_air_date_year;
  late double _vote_average;
  late String? _title;
  late String? _original_name;
  // late double _popularity;
  late String? _poster_path;
  // late String _original_language;
  // late String _original_title;
  late List<int> _genre_ids;
  // late String _backdrop_path;
  // late bool _adult;
  late String? _overview;
  late String? _release_date;
  _Result(result) {
    // _vote_count = result['vote_count'];
    // _first_air_date_year = result['first_air_date_year'];
    _id = result['id'];
    // _video = result['video'];
    _vote_average = result['vote_average'];
    _original_name = result['original_name'] as String?;
    _title = result['title'] as String?;
    // _popularity = result['popularity'];
    _poster_path = result['poster_path'] as String?;
    // _original_language = result['original_language'];
    // _original_title = result['original_title'];
    _genre_ids = <int>[];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
    // _backdrop_path = result['backdrop_path'];
    // _adult = result['adult'];
    _overview = result['overview'] as String?;
    _release_date = result['release_date'] as String?;
  }
  String? get release_date => _release_date;
  // String? get tv_release_date => _first_air_date_year.toString();

  String? get overview => _overview;

  // bool get adult => _adult;

  // String get backdrop_path => _backdrop_path;

  List<int> get genre_ids => _genre_ids;

  // String get original_title => _original_title;

  // String get original_language => _original_language;

  String? get poster_path => _poster_path;

  // double get popularity => _popularity;

  String? get title => _title ?? _original_name;

  double get vote_average => _vote_average;

  // bool get video => _video;

  int get id => _id;

  // int get vote_count => _vote_count;
}
