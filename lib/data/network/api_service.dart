import 'dart:async';

import 'package:dio/dio.dart';
import 'package:felix_it_solutions/data/models/user/user_request.dart';

import 'package:retrofit/retrofit.dart';

import '../models/ads/ads_model.dart';
import '../models/ads/ads_request.dart';
import '../models/user/user_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://qutb.uz/api')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/ads')
  Future<Ads> postAds(@Body() AdsRequest adsRequest);
  
  @POST('auth/register')
  Future<User> register(@Body() UserRequest userRequest);
}