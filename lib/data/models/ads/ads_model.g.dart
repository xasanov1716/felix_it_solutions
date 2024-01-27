// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ads _$AdsFromJson(Map<String, dynamic> json) => Ads(
      title: json['title'] as String?,
      description: json['description'] as String?,
      lat: json['lat'] as int,
      createdAt: json['created_at'] as String?,
      updateAt: json['update_at'] as String?,
      id: json['id'] as int,
    );

Map<String, dynamic> _$AdsToJson(Ads instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'update_at': instance.updateAt,
      'created_at': instance.createdAt,
      'lat': instance.lat,
      'id': instance.id,
    };
