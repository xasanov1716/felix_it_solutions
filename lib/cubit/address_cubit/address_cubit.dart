import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:felix_it_solutions/data/models/universal_response.dart';

import '../../data/repositories/address_api_repository.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({required this.addressApiRepository}) : super(AddressInitial());

  final AddressApiRepository addressApiRepository;

  String kind = "house";
  String lang = "uz_UZ";
  MapType mapType = MapType.hybrid;
  String key = '';


  String getRandomItemFromListOfLists(List<List<String>> listOfLists) {
    if (listOfLists.isEmpty) {
      return ''; // Return null if the list is empty
    }

    final random = Random();
    final randomIndex = random.nextInt(listOfLists.length);

    // Get a random list from the list of lists
    List<String> randomList = listOfLists[randomIndex];

    if (randomList.isEmpty) {
      return ''; // Return null if the selected list is empty
    }

    final randomItemIndex = random.nextInt(randomList.length);

    // Get a random item from the selected list
    String randomItem = randomList[randomItemIndex];

    return randomItem;
  }

  getAddressByLatLong({required LatLng latLng}) async {
    emit(AddressLoadingState());
    UniversalResponse universalData = await addressApiRepository.getAddress(
      latLng: latLng,
      kind: kind,
    );
    if (universalData.error.isEmpty) {
      print('data ${universalData.data}');
      emit(AddressSuccessState(address: universalData.data));
    } else {
      emit(AddressErrorState(errorText: 'no_such_identified'.tr()));
    }
  }

  void updateMapType(MapType newMapType) {
    mapType = newMapType;
    emit(AddressLoadingState());
    emit(AddressInitial());
  }
}
