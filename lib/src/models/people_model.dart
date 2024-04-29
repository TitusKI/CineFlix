// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  final int id;
  final String name;
  final String? profilePath;

  Person({required this.id, required this.name, required this.profilePath});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'], name: json['name'], profilePath: json["profile_path"]);
  }
}

class People {
  List<Person> people;

  People({required this.people});

  factory People.fromJson(Map<String, dynamic> json) {
    List<dynamic> peopleList = json['cast'];

    List<Person> people =
        peopleList.map((person) => Person.fromJson(person)).toList();
    print(people);
    return People(people: people);
  }

  @override
  String toString() => 'People(people: $people)';
}
