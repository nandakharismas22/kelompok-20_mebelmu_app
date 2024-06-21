import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer {
  final String name;
  final String npm;
  final String email;
  final String github;
  final String address;
  final String TTL;
  final String telepon;
  final AssetImage image;

  Developer({
    required this.name,
    required this.npm,
    required this.email,
    required this.github,
    required this.address,
    required this.TTL,
    required this.telepon,
    required this.image,
  });
}

class DeveloperProfileView extends StatelessWidget {
  final List<Developer> developers = [
    Developer(
      name: 'Nanda Kharisma Safitri',
      npm: '22082010036',
      address: 'Sidoarjo',
      TTL: '21 Desember 2003',
      telepon: '081234567890',
      email: 'kharismasnanda@gmail.com',
      github: 'https://github.com/nandakharismas22',
      image: AssetImage(AppAssets.profildev2),
    ),
    Developer(
      name: 'Nurul Izzah',
      npm: '22082010008',
      address: 'Surabaya',
      TTL: '2 November 2003',
      telepon: '081234567891',
      email: 'nurulizzah2727@gmail.com',
      github: 'https://github.com/nurulizzah16',
      image: AssetImage(AppAssets.profildev1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Profil Developer',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: developers.length,
        separatorBuilder: (context, index) => SizedBox(height: 30),
        itemBuilder: (context, index) {
          Developer developer = developers[index];
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 350,
                  color: AppColors.buttonColor,
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  height: 350,
                  color: Colors.grey[200],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: developer.image,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      developer.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'NPM: ${developer.npm}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Alamat: ${developer.address}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Tanggal Lahir: ${developer.TTL}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Telepon: ${developer.telepon}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.buttonColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        launch('mailto:${developer.email}');
                      },
                      child: Text(
                        'Email: ${developer.email}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.buttonColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        launch(developer.github);
                      },
                      child: Text(
                        'GitHub: ${developer.github}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.buttonColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
