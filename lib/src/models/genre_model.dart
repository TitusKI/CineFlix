// ignore_for_file: public_member_api_docs, sort_constructors_first
class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() => 'Genre(id: $id, name: $name)';
}

class GenreResponse {
  List<Genre> genres;

  GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> genreList = json['genres'];
    List<Genre> genres =
        genreList.map((genre) => Genre.fromJson(genre)).toList();

    return GenreResponse(genres: genres);
  }
}
