import 'package:flutter/material.dart';
import 'package:sapu/Screens/login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Selamat Datang di \nAplikasi SAPU \nSMP - SMA - SMK Mutiara Sandi",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "(SALURAN ASPIRASI & PENGADUAN UMUM)",
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.05),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0, color: Colors.black),
                  color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pusat Panggilan',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Row(
                      children: [
                        Icon(Icons.phone, size: screenWidth * 0.06),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          '+6285212343536',
                          style: TextStyle(fontSize: screenWidth * 0.045),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Aplikasi ini akan membantu, memudahkan \ndan mendigitalisasikan data informasi yang \nkamu butuhkan',
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.05),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/ba.png",
                      height: screenHeight * 0.35,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.02,
                    right: screenWidth * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      child: Text(
                        "Mulai",
                        style: TextStyle(fontSize: screenWidth * 0.045),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
