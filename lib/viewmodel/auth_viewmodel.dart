import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/show_toast/showTost_msg.dart';
import '../Repository/login_otp_send_repository.dart';
import '../model/login_model.dart';
import '../model/profile_model.dart';

class AuthViewmodel extends GetxController {
  var isLoading = false.obs;
  var isotp = false.obs;
Rx<ProfileModel> profile = ProfileModel().obs;
// login
  TextEditingController phone = TextEditingController();
  Rx<LoginModel> loginModel = LoginModel().obs;
  TextEditingController otpController = TextEditingController();
  Rx<String> otp = "".obs;
   late Timer _timer;
  Rx<int> secondsRemaining = 30.obs;
  Rx<bool> canResend = true.obs;
//signup
  // TextEditingController sphone = TextEditingController();
  // TextEditingController sforgetnpass = TextEditingController();
  // TextEditingController semail = TextEditingController();
  // TextEditingController sname = TextEditingController();
  // TextEditingController susername = TextEditingController();
// TextEditingController sforgetnpass= TextEditingController();
  // @override
  // void onInit() {
  //   viewAllorder();
  //   super.onInit();
  // }
  Future login() async {
    late String rsp = "";
    isLoading(true);
    isotp(true);
    try {
      var resp = await AuthApiRepository()
          .loginRepo(phone: phone.text.toString());
      print(resp);
      if (resp != null&&resp["error"]==false) {
        
        // rsp = true;
        loginModel.value =LoginModel.fromJson(resp);
        rsp = resp['messages']['status']['login_otp'].toString();
        fillOtp(rsp);
        isLoading(false);
        isotp(false);
        // allorder.value = AllOrderModel.fromJson(resp);
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString(
        //     'userId', resp["messages"]["user"]["id"].toString());
        // forgetnpasContact.text =resp["messages"]["user"]["id"].toString();
        // ShowToast(msg: resp["messages"]["status"]["login_otp"].toString());
      } else {
        ShowToast(msg: resp["messages"]["status"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      isotp(false);
    }
    return rsp;
  }
  fillOtp(String otp){
otpController.text = otp;
refresh();
  }
  void _startTimer() {
    secondsRemaining.value = 30;
    canResend.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
   
        if (secondsRemaining.value > 0) {
          secondsRemaining.value--;
        } else {
          canResend.value = true;
          _timer.cancel();
        }
      });
  }
   void resendOtp() {
    // widget.onResend();
    _startTimer();
  }
   Future sendOtp() async {
    late bool rsp = false;
    isLoading(true);
    try {
      var resp = await AuthApiRepository()
          .verifyOtp(phone: phone.text.toString());
      print(resp);
      if (resp != null&&resp["error"]==false) {
        isLoading(false);
        
        profile.value = ProfileModel.fromJson(resp);
        // rsp = resp['messages']['status']['login_otp'].toString();

        // allorder.value = AllOrderModel.fromJson(resp);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'contact', phone.text.toString());
        await prefs.setString(
            'userId', resp["messages"]["status"]["user_id"].toString());
            phone.clear();
            rsp = true;
        // forgetnpasContact.text =resp["messages"]["user"]["id"].toString();
        // ShowToast(msg: resp["messages"]["status"]["login_otp"].toString());
      } else {
        ShowToast(msg: resp["messages"]["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
    Future profileData() async {
    late String rsp = "";
    isLoading(true);
    isotp(true);
    try {
      final prefs = await SharedPreferences.getInstance();
        var contact = await prefs.getString(
            'contact');
      var resp = await AuthApiRepository()
          .verifyOtp(phone: contact??"");
      print(resp);
      if (resp != null&&resp["error"]==false) {
        
       profile.value = ProfileModel.fromJson(resp);
      } else {
        ShowToast(msg: resp["messages"]["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      isotp(false);
    }
    return rsp;
  }

 Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('contact');
    //  await prefs.remove('address');
    await prefs.remove('userId');
    return true;
  }

  // Future signup() async {
  //   late bool rsp = false;
  //   isLoading(true);
  //   try {
  //     //  if(phone.text==null||phone.text.isEmpty){
  //     //   ShowToast(msg: "First Enter Mobile Number");
  //     //  } if (phone.text.length!=10) {
  //     //     ShowToast(msg: "First Enter 10 digit mobile Number");
  //     //   } else {
  //     var resp = await AuthApiRepository().signupREpo(
  //         name: sname.text, password: sforgetnpass.text, phone: sphone.text);
  //     print(resp);
  //     if (resp != null && !resp["error"]) {
  //       isLoading(false);
  //       rsp = true;
  //       print(resp);
  //       clearSignup();
  //       // allorder.value = AllOrderModel.fromJson(resp);
  //       //       final prefs = await SharedPreferences.getInstance();
  //       // await prefs.setString('phoneNumber', phone.text);
  //       // forgetnpasContact.text =resp["messages"]["status"]["login_otp"].toString();
  //       ShowToast(msg: resp["messages"]["status"].toString());
  //     } else {
  //       ShowToast(msg: resp["messages"]["status"].toString());
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  //   return rsp;
  // }

  // updatevisible() {
  //   print("Update visible click");
  //   passwordvisible.value = !passwordvisible.value;
  // }

  // clearSignup() {
  //   phone.clear();
  //   sforgetnpass.clear();
  //   semail.clear();
  //   sphone.clear();
  //   update();
  // }
}
