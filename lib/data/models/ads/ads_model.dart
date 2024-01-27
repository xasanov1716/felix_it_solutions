import 'package:json_annotation/json_annotation.dart';

part 'ads_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Ads{
  const Ads(
      {required this.title,
        required this.description,
        required this.lat,
        required this.createdAt,
        required this.updateAt,
        required this.id});

  factory Ads.fromJson(Map<String, dynamic> json) => _$AdsFromJson(json);

  final String? title;
  final String? description;
  final String? updateAt;
  final String? createdAt;
  final int lat;
  final int id;

  Map<String, dynamic> toJson() => _$AdsToJson(this);
}