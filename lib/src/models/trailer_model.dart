class TrailerModel {
  late int _id;
  List<_Result> _result = [];
  TrailerModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'] ?? 0;
    List<_Result> temp = [];
    if (parsedJson['results'] != null) {
      for (int i = 0; i < parsedJson['results'].length; i++) {
        _Result result = _Result(parsedJson['results']
            [i]); // It adds each result like id with index 0 ..
        // to the list[]
        temp.add(result);
      }
    }

    _result = temp;
  }
  List<_Result> get results => _result;
  int get id => _id;
}

class _Result {
  late String _id;
  late String _iso_639_1;
  late String _iso_3166_1;
  late String _key;
  late String _name;
  late String _site;
  late int _size;
  late String _type;

  _Result(result) {
    _id = result['id'];
    _iso_639_1 = result['_iso_639_1'] ?? ' ';
    _iso_3166_1 = result['_iso_3166_1'] ?? ' ';
    _key = result['key'];
    _name = result['name'];
    _site = result['site'];
    _size = result['size'];
    _type = result['type'];
  }
  String get id => _id;

  String get iso_639_1 => _iso_639_1;

  String get iso_3166_1 => _iso_3166_1;

  String get key => _key;

  String get name => _name;

  String get site => _site;

  int get size => _size;

  String get type => _type;
}
