

import 'package:ashmo_delivery/screen/home/home_screen.dart';
import 'package:ashmo_delivery/screen/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Future.delayed(const Duration(seconds: 3), () async{
      // Navigate to the next screen after 3 seconds
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString("userId");
      if (userId !=null && userId !="") {
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(), // Replace with your next screen
        ),
      );
      }else{
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(), // Replace with your next screen
        ),
      );
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF2E9), // Light beige background
      body: SafeArea(
        child: Stack(
          children: [
            // Top right corner icons
           Positioned(
  top: 0,
  right: 0,
  child: SizedBox(
    width: 130,
    height: 130,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          right: 33,
          child: Transform.rotate(
            angle: 0.1,
            child: Image.asset('asset/image/image (5).png', height: 32),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Transform.rotate(
            angle: -0.1,
            child: Image.asset('asset/image/image (5).png', height: 32),
          ),
        ),
        Positioned(
          top:33,
          right: 5,
          child: Transform.rotate(
            angle: 0.2,
            child: Image.asset('asset/image/image (5).png', height: 32),
          ),
        ),
        // Positioned(
        //   top: 80,
        //   right: 35,
        //   child: Transform.rotate(
        //     angle: -0.05,
        //     child: Image.asset('asset/image/image (5).png', height: 48),
        //   ),
        // ),
      ],
    ),
  ),
),
Positioned(
  bottom: 0,
  left: 0,
  child: SizedBox(
    width: 130,
    height: 130,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          left:33,
          child: Transform.rotate(
            angle: 0.1,
            child: Image.asset('asset/image/image (5).png', height: 32),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Transform.rotate(
            angle: -0.1,
            child: Image.asset('asset/image/image (5).png', height: 32),
          ),
        ),
        Positioned(
          bottom: 33,
          left: 5,
          child: Transform.rotate(
            angle: 0.2,
            child: Image.asset('asset/image/image (5).png', height: 32),
          ),
        ),
        // Positioned(
        //   top: 80,
        //   right: 35,
        //   child: Transform.rotate(
        //     angle: -0.05,
        //     child: Image.asset('asset/image/image (5).png', height: 48),
        //   ),
        // ),
      ],
    ),
  ),
),


          
            // Center Logo
            Center(
              child: Image.asset(
                'asset/logo/image.png',
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}