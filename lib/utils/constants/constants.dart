import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

 double height = 0;
 double width = 0;

 LatLng latLng = LatLng(41.26465, 69.21627); 

 const baseUrl = "https://geocode-maps.yandex.ru";
 const String apiKey = "0966317a-0c56-4ae7-a7ee-eda74212af4d";

 String firstName = '';
 String lastName = '';
 String phone = '';
 String password = '';
 String confirmPassword = '';




void showSnackbar(BuildContext context,String message) {
 final snackBar = SnackBar(
  content: Text(message),
  duration: const Duration(seconds: 1),
  action: SnackBarAction(
   label: "cancel".tr(),
   onPressed: () {

   },
  ),
 );

 // ScaffoldMessenger is used to display the snackbar
 ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

 String title = '';
 String description = '';