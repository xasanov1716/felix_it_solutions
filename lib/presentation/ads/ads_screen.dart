import 'dart:async';

import 'package:felix_it_solutions/bloc/ads_bloc/ads_bloc.dart';
import 'package:felix_it_solutions/cubit/address_cubit/address_cubit.dart';
import 'package:felix_it_solutions/data/models/ads/ads_request.dart';
import 'package:felix_it_solutions/presentation/widgets/global_input.dart';
import 'package:felix_it_solutions/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {


  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  bool onCameraMoveStarted = false;
  String scrollAddress = '';
  TextEditingController addressController = TextEditingController();
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  void initState() {
    getLocation();
    initialCameraPosition = CameraPosition(target: LatLng(latLng.latitude, latLng.longitude),zoom: 17);
    currentCameraPosition = CameraPosition(target: LatLng(latLng.latitude, latLng.longitude),zoom: 15);
    context.read<AddressCubit>().getAddressByLatLong(latLng: latLng);
    CameraPosition(
      target: LatLng(
          latLng.latitude, latLng.longitude),
      zoom: 15,
    );
        CameraPosition(
      target: LatLng(
          latLng.latitude, latLng.longitude),
      zoom: 15,
    );
    super.initState();
  }

  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();

    latLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );
    location.onLocationChanged.listen((LocationData newLocation)
    {
      latLng = LatLng(newLocation.latitude!, newLocation.longitude!);
      debugPrint("LONGITUDE:${newLocation.longitude}");
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel_outlined)),
        title:  Text(
          "new_ads".tr(),
          style: const TextStyle(
              color: Color(0xFF01001F),
              fontWeight: FontWeight.w400,
              fontFamily: 'Mulish',
              fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if(title.isNotEmpty && description.isNotEmpty && addressController.text.isNotEmpty){
                  context.read<AdsBloc>().add(PostAdsEvent(adsRequest: AdsRequest(lot: latLng.longitude, lat: latLng.latitude, title: title, description: description)));
                }else{
                  debugPrint('Maydonla toliq emas');
                  showSnackbar(context, "fields_incomplete".tr());
                }
              },
              icon: const Icon(
                Icons.arrow_forward_outlined,
                color: Colors.blue,
              ))
        ],
      ),
      body: BlocConsumer<AdsBloc, AdsState>(
  listener: (context, state) {
    if(state is AdsSuccessState){
      title = '';
      description = '';
      showSnackbar(context, "ads_success".tr());
    }
    if(state is AdsErrorState){
      debugPrint(state.errorText);
      showSnackbar(context, state.errorText);
    }
  },
  builder: (context, state) {
    if(state is AdsLoadingState){
      return const Center(child: CupertinoActivityIndicator(),);
    }
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            GlobalTextField(
                hintText: 'enter_title'.tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: 'title'.tr(),
                onChanged: (v){
                  title = v;
                }),
            SizedBox(height: height * 16 / 812,),
            GlobalTextField(
                hintText: 'enter_desc'.tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: 'description'.tr(),
                maxLine: 5,
                onChanged: (v){
                  description = v;
                }),
            SizedBox(height: height * 16 / 812,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Expanded(child: Container(color: Colors.black,width: double.infinity,height: 2,)),
               const SizedBox(width: 2,),
                Text('change_loc'.tr(),style:const  TextStyle(fontFamily: 'Mulish',fontSize: 12,fontWeight: FontWeight.w300),),
             const   SizedBox(width: 2,),
                Expanded(child: Container(color: Colors.black,width: double.infinity,height: 2,))
              ],),
            ),
            SizedBox(height: height * 12 / 812,),
            GlobalTextField(
                hintText: 'enter_by_loc'.tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLine: 2,
                caption: 'address_by_loc'.tr(),
                controller: addressController,
                onChanged: (v){}),
            SizedBox(height: height * 12 / 812,),
            BlocConsumer<AddressCubit,AddressState>(builder: (context,state){
              if(state is AddressErrorState){
                return Text(state.errorText);
              }
              return SizedBox(
                height: height * 350 / 812,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                ),
                      child: GoogleMap(
                        onCameraMove: (CameraPosition cameraPosition) {
                          currentCameraPosition = cameraPosition;
                        },
                        onCameraIdle: () {
                          print('MAP CAMERA IDLE');
                          context.read<AddressCubit>().getAddressByLatLong(
                              latLng: currentCameraPosition.target);
                          setState(() {
                            onCameraMoveStarted = false;
                          });
                        },
                        padding: EdgeInsets.all(16),
                        onCameraMoveStarted: () {
                          setState(() {
                            onCameraMoveStarted = true;
                          });
                        },
                        mapType: MapType.normal,
                        onMapCreated: _controller.complete,
                        initialCameraPosition: initialCameraPosition,
                      ),
                    ),
                Positioned(left: 10,top: 5,child: GestureDetector(
                  onTap: (){
                _followMe(cameraPosition: initialCameraPosition);
              },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    padding: const EdgeInsets.all(8),
                    child:const Icon(Icons.gps_fixed_outlined),
                  ),
                ),),
                const    Align(
                        child: Icon(Icons.location_on_sharp)),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              if (state is AddressSuccessState) {
                                return const SizedBox();
                              }
                              return const SizedBox();
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }, listener: (context,state){
              if(state is AddressSuccessState){
                addressController.text = state.address;
              }
            }),
          ],
        ),
      );
  },
),
    );
  }


  Future<void> _followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}