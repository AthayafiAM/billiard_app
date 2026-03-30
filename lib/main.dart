import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/A.login/login_screen.dart';

void main() {
  // Mengatur agar status bar transparan dan navigasi bar sesuai tema gelap
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0F1115),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breaktime Billiards',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug merah
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // Menggunakan font sistem yang bersih (mirip San Francisco/Inter)
        fontFamily: 'Roboto', 
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}