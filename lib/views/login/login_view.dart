import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';
import 'package:furniture_shopping_app_ui/views/home/home_view.dart';
import 'package:furniture_shopping_app_ui/views/login/widgets/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backGroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                AppAssets.login,
                height: 220,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Let’s You in',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.buttonColor,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                // Validasi email dan password sebelum login
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email and password cannot be empty'),
                    ),
                  );
                  return;
                }

                // Validasi email dan password sesuai dengan yang terdaftar
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? registeredEmail = prefs.getString('email');
                String? registeredPassword = prefs.getString('password');
                if (email != registeredEmail ||
                    password != registeredPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid email or password'),
                    ),
                  );
                  return;
                }
                // Simpan email pengguna setelah berhasil login
                prefs.setString('email', email);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 200, vertical: 25),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '------ or continue with ------',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.buttonColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    AppAssets.appleIcon,
                    height: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    AppAssets.googleIcon,
                    height: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    AppAssets.facebookIcon,
                    height: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
