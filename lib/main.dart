import 'package:flutter/material.dart';
import 'package:practice_backend/session/session.dart';
import 'package:practice_backend/views/auth/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session().setSharePreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
