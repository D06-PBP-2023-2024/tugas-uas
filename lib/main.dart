import 'package:flutter/material.dart';
import 'package:tugas_uas/screen/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kindle Kids',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}