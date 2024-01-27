import 'package:json_annotation/json_annotation.dart';

part 'ads_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AdsRequest {
  final String title;
  final String description;
  final double lot;
  final double lat;

  factory AdsRequest.fromJson(Map<String, dynamic> json) =>
      _$AdsRequestFromJson(json);

  AdsRequest({
    required this.lot,
    required this.lat,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() => _$AdsRequestToJson(this);
}