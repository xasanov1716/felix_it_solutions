import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User{
  const User(
      {
    required this.message,
    required this.token
});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String? message;
  final String? token;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}