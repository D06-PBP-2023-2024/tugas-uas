import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:tugas_uas/widget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_uas/model/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<Profile>> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProduct();
  }

  Future<List<Profile>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/user/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Profile> listProfile = [];
    for (var d in data) {
      if (d != null) {
        listProfile.add(Profile.fromJson(d));
      }
    }
    return listProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      drawer: const SideDrawer(),
      body: FutureBuilder<List<Profile>>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Profile> listProfile = snapshot.data!;

            return ListView(
              padding: const EdgeInsets.all(15.0),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Center(
                    child: Text(
                      '${listProfile.first.fields.firstName} ${listProfile.first.fields.lastName}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: Text(
                      listProfile.first.fields.username,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InfoRow(
                        icon: const Icon(Icons.email),
                        value: listProfile.first.fields.email),
                    const Divider(),
                    InfoRow(
                        icon: const Icon(Icons.local_phone),
                        value: listProfile.first.fields.phoneNumber),
                    const Divider(),
                    InfoRow(
                        icon: const Icon(Icons.house),
                        value: listProfile.first.fields.domicile),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Likes', style: TextStyle(fontSize: 18)),
                          // TODO: Add likes
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Update Profile'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final Icon icon;
  final String value;

  const InfoRow({Key? key, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: icon,
          ),
          Expanded(
            flex: 4,
            child: Text(value,
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
