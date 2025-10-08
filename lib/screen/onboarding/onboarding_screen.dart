import 'package:ashmo_delivery/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'asset/image/image (7).png',
      'title': 'Welcome to Ashmo',
      'subtitle': 'Everyday Essentials',
      'desc': 'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor',
    },
    {
      'image': 'asset/image/Group 439 (1).png',
      'title': 'Fresh Products',
      'subtitle': 'Daily Needs',
      'desc': 'Get all your daily groceries\ndelivered at your doorsteps',
    },
    {
      'image': 'asset/image/Group 75 (1).png',
      'title': 'Fast Delivery',
      'subtitle': 'Doorstep Service',
      'desc': 'We ensure fast and safe delivery\nwith zero delivery charge',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF2E9),
      body: SafeArea(
        child: Stack(
          children: [
            // Top right corner image cluster
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
                      right: 48,
                      child: Transform.rotate(
                        angle: 0.1,
                        child: Image.asset('asset/image/image (5).png', height: 48),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Transform.rotate(
                        angle: -0.1,
                        child: Image.asset('asset/image/image (5).png', height: 48),
                      ),
                    ),
                    Positioned(
                      top: 48,
                      right: 5,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Image.asset('asset/image/image (5).png', height: 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(height: 20),
              
                  // Logo
                  Center(
                    child: Image.asset(
                      'asset/logo/image.png',
                      height: 40,
                    ),
                  ),
              
                  // const SizedBox(height: 20),
                  // Spacer(),
              
                  // PageView for onboarding pages
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingData.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (_, index) {
                        final item = onboardingData[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(item['image']!, height: 200),
                            const SizedBox(height: 24),
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['subtitle']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['desc']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            ///code
                          
                  
              
                  
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
              
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 10 : 6,
                        height: _currentPage == index ? 10 : 6,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.orange : Colors.black26,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
              
                  // Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: _currentPage == onboardingData.length - 1
                          ? OutlinedButton(
                              onPressed: () {
                                // Navigate to login
                                 Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(), // Replace with your next screen
        ),
      );
                                
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.orange),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'GET STARTED',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'NEXT',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                
              ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
