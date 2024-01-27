import 'package:felix_it_solutions/data/models/ads/ads_request.dart';
import 'package:felix_it_solutions/data/models/universal_response.dart';
import 'package:felix_it_solutions/data/models/user/user_request.dart';
import 'package:felix_it_solutions/data/network/api_service.dart';

import '../models/ads/ads_model.dart';

class ApiRepository {

  final ApiService apiService;

  ApiRepository({required this.apiService});

  Future<UniversalResponse> postAds(AdsRequest info)async{
    UniversalResponse data;
    try{
      final res = await apiService.postAds(info);
      data = UniversalResponse(data: res);
      print('ISHLADI');
    }
      catch(e){
      data = UniversalResponse(error: e.toString());
      print('ERROR: $e');
      }

    return data;
  }

  Future<UniversalResponse> register(UserRequest userRequest)async{
    UniversalResponse data;
    try{
      final res = await apiService.register(userRequest);
      data = UniversalResponse(data: res);
      print('ISHLADI');
    }
    catch(e){
      data = UniversalResponse(error: e.toString());
      print('ERROR: $e');
    }

    return data;
  }

}