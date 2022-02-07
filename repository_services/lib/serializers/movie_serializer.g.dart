// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_serializer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSerializer _$MovieSerializerFromJson(Map<String, dynamic> json) =>
    MovieSerializer(
      id: json['id'] as String,
      title: json['title'] as String,
      titleType: json['titleType'] as String,
      yearCreated: json['year'] as int,
      imageSerializer: json['image'] == null
          ? null
          : ImageSerializer.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieSerializerToJson(MovieSerializer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.imageSerializer,
      'titleType': instance.titleType,
      'year': instance.yearCreated,
    };
