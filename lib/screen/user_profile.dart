import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/login.dart';
import 'package:tugas_uas/widget/drawer.dart';
import 'package:tugas_uas/widget/like.dart';
import 'package:tugas_uas/widget/comment.dart';
import 'package:tugas_uas/widget/reading-list.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const SideDrawer(),
        body: Column(
          children: <Widget>[
            const Expanded(
              flex: 1,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Welcome!', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    Text('First Name Last Name',
                        style: TextStyle(fontSize: 18)),
                    Text('Username',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const InfoRow(title: 'Email', value: 'email'),
                      const Divider(),
                      const InfoRow(
                          title: 'Phone number', value: 'phone number'),
                      const Divider(),
                      const InfoRow(title: 'Domicile', value: 'domicile'),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text('Update Profile')),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () async {
                                final request = Provider.of<CookieRequest>(
                                    context,
                                    listen: false);
                                final response = await request.logout(
                                    "http://kindle-kids-d06-tk.pbp.cs.ui.ac.id/auth/logout/");
                                String message = response["message"];
                                if (response['status']) {
                                  String uname = response["username"];
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("$message Sampai jumpa, $uname."),
                                  ));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginApp()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("$message"),
                                  ));
                                }
                              },
                              child: const Text('Log Out')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Likes', style: TextStyle(fontSize: 18)),
                      LikeWidget(),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Comments', style: TextStyle(fontSize: 18)),
                      CommentPage(),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Reading List', style: TextStyle(fontSize: 18)),
                      ReadingList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(title, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 2,
          child: Text(value,
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ),
      ],
    );
  }
}
