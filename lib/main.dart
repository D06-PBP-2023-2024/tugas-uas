import 'package:flutter/material.dart';
import 'login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/home.dart';
import 'package:tugas_uas/screen/login.dart';
import 'package:tugas_uas/screen/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
