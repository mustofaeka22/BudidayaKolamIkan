import 'package:flutter/material.dart';
import 'screens/halaman_beranda.dart';

void main() {
  runApp(const KelolaKolamApp());
}

class KelolaKolamApp extends StatelessWidget {
  const KelolaKolamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pencatatan Budidaya Ikan Air Tawar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        fontFamily: 'Roboto',
      ),
      home: const HalamanBeranda(),
      debugShowCheckedModeBanner: false,
    );
  }
}