import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/login.dart';
import 'package:tugas_uas/widget/drawer.dart';
import 'package:tugas_uas/model/profile.dart';
import 'package:tugas_uas/screen/profile_form.dart';
import 'package:tugas_uas/model/like.dart';
import 'package:tugas_uas/model/reading_list.dart';
import 'package:tugas_uas/model/comment.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Profile>> fetchProfile(CookieRequest request) async {
    var data = await request.get(
        'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/user/json/',
    );

    List<Profile> list_profile = [];
    for (var d in data) {
      if (d != null) {
        list_profile.add(Profile.fromJson(d));
      }
    }
    return list_profile;
  }

  Future<Like> fetchLikes(CookieRequest request) async {
    var response = await request.get(
      'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/user/liked-books/',
    );

    String jsonResponse = json.encode(response);
    return Like.fromJson(json.decode(jsonResponse));
  }

  Future<ReadingList> fetchReadinglist(CookieRequest request) async {
    var response = await request.get(
      'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/user/readinglist-books/',
    );

    String jsonResponse = json.encode(response);
    return ReadingList.fromJson(json.decode(jsonResponse));
  }

  Future<Comment> fetchComment(CookieRequest request) async {
    var response = await request.get(
      'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/user/comment-books/',
    );

    String jsonResponse = json.encode(response);
    return Comment.fromJson(json.decode(jsonResponse));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Profile',
        style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const SideDrawer(),
      body: FutureBuilder(
        future: Future.wait([
          fetchProfile(request),
          fetchLikes(request),
          fetchReadinglist(request),
          fetchComment(request),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Profile> listProfile = snapshot.data![0];
            Like listLike = snapshot.data![1] ?? Like(books: []);
            ReadingList listReadinglist = snapshot.data![2] ?? ReadingList(books: []);
            Comment listComment = snapshot.data![3] ?? Comment(books: []);

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
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text('Likes', style: TextStyle(fontSize: 18)),
                          ),
                          listLike.books.isEmpty
                              ? const Text('No liked books')
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: listLike.books.length,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder: (context, index) {
                                    final book = listLike.books[index];
                                    final title = book.title;
                                    final coverUrl = book.coverUrl;
                                    final author = book.author;

                                    return ListTile(
                                      title: Text(title),
                                      leading: Image.network(coverUrl),
                                      subtitle: Text(author),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text('Comment', style: TextStyle(fontSize: 18)),
                          ),
                          listComment.books.isEmpty
                              ? const Text('No comment yet')
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: listComment.books.length,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder: (context, index) {
                                    final book = listComment.books[index];
                                    final title = book.title;
                                    final coverUrl = book.coverUrl;
                                    final comment = book.comment;

                                    return ListTile(
                                      title: Text(title),
                                      leading: Image.network(coverUrl),
                                      subtitle: Text(comment),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text('Reading List', style: TextStyle(fontSize: 18)),
                          ),
                          listReadinglist.books.isEmpty
                              ? const Text('No books in reading list')
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: listReadinglist.books.length,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder: (context, index) {
                                    final book = listReadinglist.books[index];
                                    final title = book.title;
                                    final coverUrl = book.coverUrl;
                                    final author = book.author;

                                    return ListTile(
                                      title: Text(title),
                                      leading: Image.network(coverUrl),
                                      subtitle: Text(author),
                                    );
                                  },
                                ),
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
                          onPressed: () async {
                            final response = await request.logout(
                                "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/auth/logout/");
                            String message = response["message"];
                            if (response['status']) {
                              String uname = response["username"];
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("$message See you again, $uname!"),
                              ));
                              loggedInUsername = "";
                              isLoggedIn = false;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("$message"),
                              ));
                            }
                          },
                          child: const Text('Log Out')
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }
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