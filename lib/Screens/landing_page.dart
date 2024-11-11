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
    // Mendapatkan ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Menyelaraskan ke kiri
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Selamat Datang di \nAplikasi SAPU \nSMP - SMA - SMK Mutiara Sandi",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "(SALURAN ASPIRASI & PENGADUAN UMUM)",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.05),
              Container(
                height: screenHeight * 0.1,
                width: screenWidth * 0.9,
                padding: EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  ),
                  color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pusat Panggilan',
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Menyelaraskan ke kiri
                      children: [
                        Icon(Icons.phone, size: screenWidth * 0.06),
                        SizedBox(width: 8),
                        Text(
                          '+6285212343536',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Aplikasi ini akan membantu, memudahkan \ndan mendigitalisasikan data informasi yang \nkamu butuhkan',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.05),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Tetap menyelaraskan gambar ke kiri
                    children: [
                      Image.asset(
                        "assets/images/ba.png",
                        height: screenHeight * 0.35,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black, // Warna latar belakang tombol
                          foregroundColor: Colors.white, // Warna teks tombol
                          fixedSize: Size(150, 20)),
                      child: Text(
                        "Mulai",
                        style: TextStyle(fontSize: screenWidth * 0.045),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
