import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/auth_service.dart';
import '../home/home_screen.dart';
import '../authentication/phone_auth_screen.dart';

class AuthScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://firebase.google.com/images/brand-guidelines/logo-logomark.png",
              height: 120,
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to Foody App",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.g_mobiledata_rounded,
                  size: 24, color: Colors.white),
              label: Text(
                "Login with Google",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              onPressed: () async {
                User? user = await _authService.signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Google Sign-In Failed")),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, //
                foregroundColor: Colors.white, //
                minimumSize: Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.phone, size: 24, color: Colors.white),
              label: Text(
                "Login with Phone",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PhoneAuthScreen()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
