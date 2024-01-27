import 'package:felix_it_solutions/data/models/address/geocoding/geocoder_meta_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'meta_data_property.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaDataProperty {
  @JsonKey(name: 'GeocoderMetaData')
  GeocoderMetaData geocoderMetaData;

  MetaDataProperty({required this.geocoderMetaData});

  factory MetaDataProperty.fromJson(Map<String, dynamic> json) => _$MetaDataPropertyFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataPropertyToJson(this);
}
