import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/views/login/login_view.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingFrame(
                imagePath: onboardingPages[index].imagePath,
                title: onboardingPages[index].title,
                subtitle: onboardingPages[index].subtitle,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: onboardingPages.length,
                effect: WormEffect(
                  dotColor: AppColors.buttonColor,
                  activeDotColor: AppColors.lightRed,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
          if (_currentPage == onboardingPages.length - 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: ElevatedButton(
                  onPressed: _navigateToLogin,
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: AppColors.whiteColor), // Ubah warna teks di sini
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

class OnboardingFrame extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingFrame({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 450),
          const SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.buttonColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.buttonColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Sample data for onboarding pages
List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    imagePath: AppAssets.welcome4,
    title: 'Welcome to Mebelmu',
    subtitle: 'Discover the best furniture for your home.',
  ),
  OnboardingPage(
    imagePath: AppAssets.welcome2,
    title: 'Explore Our Collection',
    subtitle: 'Find the perfect pieces for every room.',
  ),
  OnboardingPage(
    imagePath: AppAssets.welcome3,
    title: 'Easy Shopping',
    subtitle: 'Enjoy a seamless shopping experience.',
  ),
];

class OnboardingPage {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
