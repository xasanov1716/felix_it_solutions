import 'package:felix_it_solutions/bloc/auth_bloc/auth_bloc.dart';
import 'package:felix_it_solutions/data/models/user/user_request.dart';
import 'package:felix_it_solutions/presentation/ads/ads_screen.dart';
import 'package:felix_it_solutions/presentation/widgets/global_input.dart';
import 'package:felix_it_solutions/utils/constants/constants.dart';
import 'package:felix_it_solutions/utils/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {


  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is AuthSuccessState){
      showSnackbar(context, "success_register".tr());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdsScreen()));
    }
    if(state is AuthErrorState){
      showSnackbar(context, state.errorText);
    }
  },
  builder: (context, state) {
    if(state is AuthLoadingState){
      return const Center(child: CupertinoActivityIndicator(),);
    }
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         const   SizedBox(height: 18,),
            Center(
                child: Image.asset(
              AppImages.circleUser,
              height: height * 281 / 812,
              width: width * 295 / 375,
            )),
            SizedBox(
              height: height * 29 / 812,
            ),
            Text("sign_up".tr(),style: const TextStyle(color: Color(0xFF01001F),fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Mulish'),),
            SizedBox(
              height: height * 24 / 812,
            ),
            GlobalTextField(
              caption: 'f_name'.tr(),
                hintText: 'enter_f_name'.tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (v) {
                firstName = v;
                }),
            const SizedBox(height: 12,),
            GlobalTextField(
              caption: "l_name".tr(),
                hintText: "enter_l_name".tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (v) {
                lastName = v;
                }),
        const    SizedBox(height: 12,),
            GlobalTextField(
              focusNode: focusNode,
              isPhone: true,
              caption: "phone".tr(),
                hintText: "(__) ___-__-__",
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onChanged: (v) {
                phone = v;
                  if(v.length == 14){
                    focusNode.unfocus();
                  }
                }),
           const SizedBox(height: 12,),
            GlobalTextField(
              caption: "password".tr(),
                hintText: "enter_password".tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (v) {
                password = v;
                }),
          const  SizedBox(height: 12,),
            GlobalTextField(
              caption: "c_password".tr(),
                hintText: "enter_c_password".tr(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (v) {
                confirmPassword = v;
                }),
            SizedBox(height: height * 8 / 812,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: (){
                  if(password == confirmPassword){
                    if(firstName.isNotEmpty && lastName.isNotEmpty && phone.isNotEmpty && password.isNotEmpty){
                      context.read<AuthBloc>().add(RegisterEvent(userRequest: UserRequest(firstName: firstName, lastName: lastName, phoneNumber: phone, password: password)));
                    }else{
                      showSnackbar(context, "fields_incomplete".tr());
                    }
                  }else{
                      showSnackbar(context, "confirm_error".tr());
                      debugPrint(password);
                      debugPrint(confirmPassword);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black
                  ),
                  child: Center(child: Text('save'.tr(),style: const TextStyle(color: Colors.white,fontFamily: 'Mulish'),)),
                ),
              ),
            ),
            SizedBox(height: height * 50 / 812,)
          ],
        ),
      );
  },
),
    );
  }
}
