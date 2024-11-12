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

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1), // Padding responsif
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200), // Jarak atas untuk menyeimbangkan tampilan
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1, // Ukuran font responsif
                    fontFamily: "Poppins-SemiBold",
                  ),
                ),
                SizedBox(height: 75),
                Image.asset(
                  'assets/images/ilogin.png',
                  height: screenWidth * 0.35, // Ukuran gambar responsif
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 50),
                TextField(
                  controller: _emailCotroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20),
                // TextField untuk Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      labelText: 'kata sandi',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )),
                ),

                SizedBox(height: 30),
                // Tombol Login
                ElevatedButton(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
