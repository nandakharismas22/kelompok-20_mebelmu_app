import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';
import 'package:furniture_shopping_app_ui/views/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
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
                AppAssets.signup,
                height: 220,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Create Your Account',
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
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
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
                final username = usernameController.text;
                final email = emailController.text;
                final password = passwordController.text;

                // Validasi email, username, dan password sebelum sign up
                if (username.isEmpty || email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Username, email, and password cannot be empty'),
                    ),
                  );
                  return;
                }

                // Simpan username, email, dan password pengguna setelah berhasil sign up
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('username', username);
                prefs.setString('email', email);
                prefs.setString('password', password);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sign Up Successful!'),
                  ),
                );

                // Navigasi ke halaman login untuk verifikasi
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text(
                'Sign Up',
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
            const SizedBox(height: 15),
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
