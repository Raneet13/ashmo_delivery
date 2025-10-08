import 'package:ashmo_delivery/core/show_toast/showTost_msg.dart';
import 'package:ashmo_delivery/screen/login/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../viewmodel/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController phoneController = TextEditingController();
  // String completePhoneNumber = '';
  // bool isValidNumber = false;
  final login = Get.find<AuthViewmodel>();
  // @override
  // void dispose() {
  //   phoneController.dispose();
  //   super.dispose();
  // }

  // void onPhoneChanged(String number, String countryCode) {
  //   setState(() {
  //     completePhoneNumber = '$countryCode$number';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Obx(
            ()=> Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'asset/logo/image.png', // Replace with your logo asset
                    height: 60,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Login to your account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login or create an account',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  IntlPhoneField(
                    controller: login.phone,
                    
                    decoration: const InputDecoration(
                      labelText: 'Enter mobile number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    // onChanged: (phone) {
                    //   onPhoneChanged(phone.number, phone.countryCode);
              
                    //   setState(() {
                    //     isValidNumber = phone.number.length >= 10;
                    //   });
                    // },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: !login.isLoading.value
                        ? () {
                          if (login.phone.text.length!=10) {
                            ShowToast(msg: "Enter The Valid Phone Number");
                          } else {
                            login.login().then((v){
                            if(v !=""){
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  OtpVerificationPage(
                                        phoneNumber: "+91 ${login.phone.text}",
                                        otp: v,
                                      )),
                                    );
                            }
                          });
                           
                          }
                           
                          }
                        : null, // disabled if invalid
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: login.isLoading.value?SizedBox(child: CircularProgressIndicator(),): const Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  // !login.isLoading.value 
                  //   ? Text('By continuing, you agree to our Terms and Conditions.', style: TextStyle(color: Colors.grey, fontSize: 12),) 
                  //   : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
