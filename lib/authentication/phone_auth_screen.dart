import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_swissy/home/home_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool otpSent = false;
  String verificationId = "";

  void sendOTP() async {
    final phone = phoneController.text.trim();
    if (phone.isEmpty || !phone.startsWith('+')) {
      showError("Please enter a valid phone number with country code.");
      return;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          navigateToHomeScreen();
        },
        verificationFailed: (FirebaseAuthException e) {
          showError("Verification failed: ${e.message}");
        },
        codeSent: (String verId, int? resendToken) {
          setState(() {
            otpSent = true;
            verificationId = verId;
          });
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      showError("Error occurred: $e");
    }
  }

  void verifyOTP() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty || otp.length != 6) {
      showError("Please enter a valid 6-digit OTP.");
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      navigateToHomeScreen();
    } catch (e) {
      showError("Failed to verify OTP: $e");
    }
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.red))),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.green))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 40),
                Text(
                  otpSent
                      ? "Enter the OTP sent to your phone"
                      : "Enter your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                if (!otpSent)
                  buildInputField(
                    controller: phoneController,
                    hint: "Phone Number (+1234567890)",
                    prefixIcon: Icons.phone,
                  )
                else
                  buildInputField(
                    controller: otpController,
                    hint: "Enter OTP",
                    prefixIcon: Icons.lock,
                  ),
                SizedBox(height: 20),
                buildActionButton(
                  onPressed: otpSent ? verifyOTP : sendOTP,
                  title: otpSent ? "Verify OTP" : "Send OTP",
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget buildActionButton({
    required VoidCallback onPressed,
    required String title,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12),
        minimumSize: Size(double.infinity, 45),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
