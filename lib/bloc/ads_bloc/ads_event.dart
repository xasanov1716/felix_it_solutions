part of 'ads_bloc.dart';

@immutable
abstract class AdsEvent {}


class PostAdsEvent extends AdsEvent {
  final AdsRequest adsRequest;

  PostAdsEvent({required this.adsRequest});
}