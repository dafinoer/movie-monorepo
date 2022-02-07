import 'package:repository_core/model/movie.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:repository_services/serializers/image_serializer.dart';

part 'movie_serializer.g.dart';

@JsonSerializable()
class MovieSerializer {
  final String id;

  final String title;

  @JsonKey(name: 'image')
  final ImageSerializer? imageSerializer;

  final String titleType;

  @JsonKey(name: 'year')
  final int yearCreated;

  const MovieSerializer({
    required this.id,
    required this.title,
    required this.titleType,
    required this.yearCreated,
    this.imageSerializer
  });

  factory MovieSerializer.fromJson(Map<String, dynamic> json) =>
      _$MovieSerializerFromJson(json);
}
