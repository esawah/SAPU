import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sapu/Screens/login_page.dart';

class LandingPage2 extends StatelessWidget {
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Text
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.08,
                    top: screenHeight * 0.03,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: 'Selamat Datang di\n'),
                        TextSpan(text: 'Aplikasi SAPU\n'),
                        TextSpan(text: 'SMP - SMA - SMK Mutiara Sandi'),
                      ],
                    ),
                  ),
                ),
                // Subtitle Text
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.04),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontSize: screenWidth * 0.04,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(
                              text: '(SALURAN ASPIRASI & PENGADUAN UMUM)\n'),
                        ],
                      ),
                    ),
                  ),
                ),
                // Contact Box
                Center(
                  child: Container(
                    width: screenWidth * 0.85,
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.008),
                    margin: EdgeInsets.only(top: screenHeight * 0.015),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1.0, color: Colors.black),
                      color: Colors.amber,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pusat Panggilan',
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontSize: screenWidth * 0.045,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              '+6285212343536',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: screenWidth * 0.045,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Description Text
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.08,
                    top: screenHeight * 0.03,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontSize: screenWidth * 0.04,
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(
                            text: 'Aplikasi ini akan membantu, memudahkan\n'),
                        TextSpan(
                            text:
                                'dan mendigitalisasikan data informasi yang\n'),
                        TextSpan(text: 'kamu butuhkan'),
                      ],
                    ),
                  ),
                ),
                // Stack with SVG and Image
                Stack(
                  children: [
                    Positioned(
                      left: -screenWidth *
                          0.5, // Adjust position based on screen width
                      top: screenHeight * 0.12,
                      child: Container(
                        width: screenWidth *
                            1.2, // Adjust width for responsiveness
                        height: screenHeight * 0.4,
                        child: SvgPicture.asset(
                          "assets/images/polygon.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.08),
                        child: Image.asset(
                          "assets/images/ba.png",
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // "Mulai" Button
                    Positioned(
                      bottom: screenHeight * 0.015,
                      right: screenWidth * 0.04,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text('Mulai'),
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(screenWidth * 0.35, screenHeight * 0.05),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
