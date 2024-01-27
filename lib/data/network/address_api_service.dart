import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:felix_it_solutions/data/local/storage_repo.dart';
import 'package:felix_it_solutions/utils/constants/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:felix_it_solutions/data/models/universal_response.dart';
import 'package:flutter/cupertino.dart';

import '../models/address/geocoding/geocoding.dart';

class AddressApiService {
  // DIO SETTINGS

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  AddressApiService() {
    _init();
  }

  _init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${handler.isCompleted}");
          // return handler.resolve(Response(requestOptions: requestOptions, data: {"name": "ali", "age": 26}));
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${handler.isCompleted}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalResponse> getAddress(
      {required LatLng latLng,
        required String kind}) async {
    Response response;
    try {
      response = await dio.get(
        '/1.x/',
        queryParameters: {
          "apikey": apiKey,
          "geocode": "${latLng.longitude}, ${latLng.latitude}",
          "lang": StorageRepository.getString('lan'),
          "format": "json",
          "kind": kind,
          "rspn": "1",
          "results": "1",
        },
      );

      if (response.statusCode == 200) {
        String text = tr('no_such_identified');
        Geocoding geocoding = Geocoding.fromJson(response.data);
        if (geocoding.response.geoObjectCollection.featureMember.isNotEmpty) {
          text = geocoding.response.geoObjectCollection.featureMember[0].geoObject.metaDataProperty
              .geocoderMetaData.text;
        }
        return UniversalResponse(data: text);
      }
      return UniversalResponse(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        print('Address api ishladi');
        return UniversalResponse(data: e.response!.data);
      } else {
        return UniversalResponse(error: e.message!);
      }
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }
}
