import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/views/login/widgets/wellcomesreen.dart';
import 'package:furniture_shopping_app_ui/views/profile/widgets/developer_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.buttonColor,
        flexibleSpace: Container(
          height: 700,
          color: AppColors.buttonColor,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 200,
            color: AppColors.buttonColor,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                SharedPreferences prefs = snapshot.data!;
                String email = prefs.getString('email') ?? '';
                String username = prefs.getString('username') ?? '';

                return Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: (MediaQuery.of(context).size.width / 2) - 90,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage(AppAssets.profiluser),
                      ),
                    ),
                    Positioned(
                      top: 250,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            username,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 400,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.person,
                                color: AppColors.buttonColor),
                            title: Text('Profil Developer'),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: AppColors.buttonColor),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeveloperProfileView(),
                                ),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.red),
                            title: Text('Logout',
                                style: TextStyle(color: Colors.red)),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: Colors.red),
                            onTap: () async {
                              // Clear SharedPreferences on logout
                              await prefs.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
