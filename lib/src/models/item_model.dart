import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  int page;

  @HiveField(1)
  List<Result> results;

  List<Result> similarTitles = [];

  ItemModel({required this.page, required this.results});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      page: json['page'],
      results: (json['results'] as List)
          .map((result) => Result.fromJson(result))
          .toList(),
    );
  }
  Result? populateSimilarTitles(String clickedTitle) {
    Result? clickedItem;

    // Find all items with the same title
    List<Result> similarTitles =
        results.where((result) => result.title == clickedTitle).toList();

    if (similarTitles.length == 1) {
      clickedItem = similarTitles[0];
    } else {
      clickedItem = null;
    }
    similarTitles = similarTitles;
    return clickedItem;
  }

  void setResults(List<Result> results) {
    results = results;
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 1)
class Result {
  // @HiveField(0)
  // bool adult;

  @HiveField(2)
  int id;

  @HiveField(6)
  String overview;

  @HiveField(8)
  String? posterPath;

  @HiveField(9)
  String? firstAirDate;

  @HiveField(10)
  String? name;

  @HiveField(11)
  double? voteAverage;

  @HiveField(12)
  int? voteCount;
  @HiveField(13)
  String? releaseDate;
  @HiveField(14)
  String? title;

  Result({
    // required this.adult,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.title,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      // adult: json['adult'],
      id: json['id'] as int,
      overview: json['overview'],
      posterPath: json['poster_path'],
      firstAirDate: json['first_air_date'],
      name: json['name'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      releaseDate: json['releaseDate'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'adult': adult,
      'id': id,
      'overview': overview,
      'poster_path': posterPath,
      'first_air_date': firstAirDate,
      'name': name,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
