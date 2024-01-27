part of 'ads_bloc.dart';

@immutable
abstract class AdsState {}

class AdsInitial extends AdsState {}

class AdsLoadingState extends AdsState {}

class AdsSuccessState extends AdsState {}

class AdsErrorState extends AdsState {
  final String errorText;

  AdsErrorState({required this.errorText});
}