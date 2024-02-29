import "package:meta/meta.dart";

@immutable
abstract class  SearchEvent {
  
}
class PerformSearchEvent extends SearchEvent{
  final String query;
  final String mediaType;
  PerformSearchEvent({ required this.query,  required this.mediaType});
}