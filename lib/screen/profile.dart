import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/login.dart';
import 'package:tugas_uas/widget/drawer.dart';
import 'package:tugas_uas/model/profile.dart';
import 'package:tugas_uas/screen/profile_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
Future<List<Profile>> fetchProduct(CookieRequest request) async {
    var data = await request.get(
        'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/user/json',
    );

    List<Profile> list_profile = [];
    for (var d in data) {
      if (d != null) {
        list_profile.add(Profile.fromJson(d));
      }
    }
    return list_profile;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
  future: fetchProduct(request),
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
                '${listProfile.first.fields.firstName ?? 'Name'} ${listProfile.first.fields.lastName ?? ''}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text(
                loggedInUsername,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InfoRow(icon: const Icon(Icons.email), value: listProfile.first.fields.email ?? 'email'),
              const Divider(),
               InfoRow(icon: const Icon(Icons.local_phone), value: listProfile.first.fields.phoneNumber ?? 'phone number'),
              const Divider(),
              InfoRow(icon: const Icon(Icons.house), value: listProfile.first.fields.domicile ?? 'domicile'),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateProfilePage(),
                      ),
                    );
                  },
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
  final String? value;

  const InfoRow({Key? key, required this.icon, required this.value}) : super(key: key);

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
            child: Text(
              value != null ? value! : 'Placeholder',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
