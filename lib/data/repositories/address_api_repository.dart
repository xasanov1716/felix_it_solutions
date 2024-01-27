import 'package:felix_it_solutions/data/models/universal_response.dart';
import 'package:felix_it_solutions/data/network/address_api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressApiRepository {
  final AddressApiService apiService;
  AddressApiRepository({required this.apiService});
  Future<UniversalResponse> getAddress({
    required LatLng latLng,
    required String kind,
  }) async =>
      apiService.getAddress(latLng: latLng, kind: kind);
}
