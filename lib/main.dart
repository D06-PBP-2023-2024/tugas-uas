import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/login.dart';
=======
import 'package:tugas_uas/screen/home.dart';
import 'login.dart';
>>>>>>> ff5f80b (pull from vanya)

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Kindle Kids',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const LoginApp(),
      ),
=======
    return MaterialApp(
      title: 'Kindle Kids',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Change this line
>>>>>>> ff5f80b (pull from vanya)
    );
  }
}
