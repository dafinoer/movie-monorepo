import 'package:json_annotation/json_annotation.dart';

part 'image_serializer.g.dart';

@JsonSerializable()
class ImageSerializer {
  final String id;

  final String? url;

  ImageSerializer(this.id, this.url);

  factory ImageSerializer.fromJson(Map<String, dynamic> json) =>
      _$ImageSerializerFromJson(json);
}
