import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_swissy/utils/theme.dart';

import 'firebase_options.dart';
import 'authentication/auth_screen.dart';
import 'package:provider/provider.dart';
import 'home/cart_provider.dart';
import 'home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food App",
      theme: appTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // 🔄 Loading Screen
          }
          if (snapshot.hasData) {
            return HomeScreen(); //
          }
          return AuthScreen();
        },
      ),
    );
  }
}
