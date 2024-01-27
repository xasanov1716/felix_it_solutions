import 'package:json_annotation/json_annotation.dart';


part 'user_request.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class UserRequest {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  UserRequest(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.password});


  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);

}
