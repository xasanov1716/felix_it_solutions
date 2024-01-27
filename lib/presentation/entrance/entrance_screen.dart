import 'package:felix_it_solutions/data/local/storage_repo.dart';
import 'package:felix_it_solutions/data/models/ads/ads_request.dart';
import 'package:felix_it_solutions/data/network/api_service.dart';
import 'package:felix_it_solutions/data/repositories/api_repository.dart';
import 'package:felix_it_solutions/presentation/auth/auth_screen.dart';
import 'package:felix_it_solutions/utils/constants/constants.dart';
import 'package:felix_it_solutions/utils/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';


class EntranceScreen extends StatefulWidget {
  const EntranceScreen({super.key});

  @override
  State<EntranceScreen> createState() => _EntranceScreenState();
}

class _EntranceScreenState extends State<EntranceScreen> {


  int selectedIndex = 0;

  String selectedValue = 'Uzbekistan';

  List<String> dropdownItems = [
    'Uzbekistan',
    'Russian',
    'English'
  ];


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.location,height: height * 72 / 812,width: width * 72 / 375,),
              Text("logo".tr(),style: const TextStyle(color: Color(0xFF01001F),fontSize: 36,fontWeight: FontWeight.w600,fontFamily: 'Mulish'),)
            ],
          )),
          const Spacer(),
          Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text("language".tr(),style: const TextStyle(color: Color(0xFF232638),fontWeight: FontWeight.w400,fontSize: 16,fontFamily: 'Mulish'),),
            ),
          ],),
          SizedBox(height: 4 * height / 812,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE7ECF3)),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white// Use the desired background color
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(12),
              items: dropdownItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items ,style: const TextStyle(color: Color(0xFF949CA9),fontFamily: 'Mulish'),),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                  if(selectedValue == 'Uzbekistan'){
                    changeLanguage('uz');
                  }
                  else if(selectedValue == 'English'){
                    changeLanguage('en');
                  }else{
                    changeLanguage('ru');
                  }
                });
              },
              hint: Text(selectedValue), // Placeholder text
            ),
          ),
          SizedBox(height: 18 * height / 812,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen()));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration:const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
              ),
              child: const Center(child: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 24,)),
            ),
          ),
          SizedBox(height: height * 110 / 812,)
          ],
      ),
    );
  }

  changeLanguage(String langCode) {
    if (langCode == "uz") {
      selectedIndex = 0;
      context.setLocale(const Locale('uz', 'UZ'));
      StorageRepository.putString('lan', 'uz_UZ');
    } else if (langCode == "en") {
      selectedIndex = 1;
      context.setLocale(const Locale('en', 'EN'));
      StorageRepository.putString('lan', 'en_GB');

    } else {
      selectedIndex = 2;
      context.setLocale(const Locale('ru', 'RU'));
      StorageRepository.putString('lan', 'ru_RU');
    }
    setState(() {});
  }
}
