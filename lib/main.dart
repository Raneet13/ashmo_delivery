import 'package:ashmo_delivery/screen/splash/splash_screen.dart';
import 'package:ashmo_delivery/viewmodel/allorder_viewmodel.dart';
import 'package:ashmo_delivery/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Get.lazyPut<HomeViewmodel>(() => HomeViewmodel(), fenix: true);
    Get.lazyPut<AuthViewmodel>(() => AuthViewmodel(), fenix: true);
  // Get.lazyPut<CheckoutViewmodel>(() => CheckoutViewmodel(), fenix: true);
   Get.lazyPut<AllorderViewmodel>(() => AllorderViewmodel(), fenix: true);
  runApp(SafeArea(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        builder: (context, child) {
    // Wrap every page in SafeArea automatically
    return SafeArea(
      child: child ?? const SizedBox(),
    );
  },
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        ),
        scaffoldBackgroundColor:  Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
