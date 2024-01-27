part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}


class RegisterEvent extends AuthEvent {

  final UserRequest userRequest;

  RegisterEvent({required this.userRequest});
}