// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsRequest _$AdsRequestFromJson(Map<String, dynamic> json) => AdsRequest(
      lot: json['lot'] as double,
      lat: json['lat'] as double,
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AdsRequestToJson(AdsRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'lot': instance.lot,
      'lat': instance.lat,
    };
