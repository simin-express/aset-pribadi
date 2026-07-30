import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AsetRumahApp());
}

class AsetRumahApp extends StatelessWidget {
  const AsetRumahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aset Rumah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
