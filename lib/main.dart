import 'package:flutter/material.dart';
import 'login_page_manual_creative.dart'; 
import 'dashboard_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
          // Sesuaikan dengan warna gradient login_page_creative/AI
          primary: const Color(0xFF673AB7), // Ungu
          secondary: const Color(0xFF42A5F5), // Biru terang
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPageManualCreative(), // Gunakan LoginPageManualCreative jika LoginPageAI tidak ada
      routes: {
        '/dashboard': (context) => const DashboardPageAI(), // Mengarah ke DashboardPageAI
      },
    );
  }
}