import 'package:flutter/material.dart';
import 'package:sapu/Screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCotroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          // Padding responsif
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: screenWidth * 0.25)),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: screenWidth * 0.1, // Ukuran font responsif
                      fontFamily: "Poppins-SemiBold",
                    ),
                  ),
                  Image.asset(
                    'assets/images/ilogin.png',
                    height: screenWidth * 0.35, // Ukuran gambar responsif
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.05)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: TextField(
                      controller: _emailCotroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'kata sandi',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Tombol Login
              SizedBox(height: screenWidth * 0.1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailCotroller.text == 'esa@gmail.com' &&
                        _passwordController.text == '12345') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("email atau kata sandi salah")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      fixedSize: Size(500, 50)),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
