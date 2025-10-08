import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/show_toast/showTost_msg.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../home/home_screen.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String otp;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.otp
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
    final login = Get.find<AuthViewmodel>();
  

  @override
  void initState() {
    super.initState();
    login.fillOtp(widget.otp??"");
  }


  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  // void _resendOtp() {
  //   // widget.onResend();
  //   _startTimer();
  // }

  // void _verifyOtp(value) {
  //   setState(() {
  //     isValidOTP = value.length == 5;
  //     print(isValidOTP);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Obx(
            ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Image.asset(
                  'asset/logo/image.png', // Replace with your logo asset
                  height: 60,
                ),
                const SizedBox(height: 32),
            
                const Text("Enter OTP", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            
                const SizedBox(height: 8),
            
                Text("OTP sent to ${widget.phoneNumber}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
            
                const SizedBox(height: 32),
            
                // OTP Boxes 
                Obx(
                  ()=>login.isotp.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): PinCodeTextField(
                    controller: login.otpController,
                    appContext: context,
                    
                    autoDisposeControllers: false,
                    length: 4,
                    // onChanged: (value) {
                    //   _verifyOtp(value);
                    // },
                    // onCompleted: (value) => {
                    //   otpCode = value,
                    //   _verifyOtp(value)
                    // },
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.orange,
                      activeColor: Colors.orange,
                    ),
                  ),
                ),
            
                const SizedBox(height: 16),
            
                login.canResend.value
                    ? GestureDetector(
                        onTap:(){
                          login.login();
                          login.resendOtp();
                          },
                        child: const Text("Resend SMS", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      )
                    : Text("Didn't get the OTP? Resend SMS in ${login.secondsRemaining.value} s", style: const TextStyle(color: Colors.grey)),
            
                Spacer(),
                ElevatedButton(
                  onPressed: !login.isLoading.value
                      ? () {
                        if (login.otpController.text.toString() == login.loginModel.value.messages?.status?.loginOtp.toString()) {
                          login.sendOtp().then((v){
                            if (v) {
                               Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                            }
                           
                          });
                        }else{
                          ShowToast(msg: "Otp Is not Correct Enter Valid OTP");
                        }
                          
                          // print("Called");
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child:login.isLoading.value?SizedBox(height: 20,width: 20, child: CircularProgressIndicator(),): const Text('Verify', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
