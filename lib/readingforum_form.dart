import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/home.dart';
import 'package:tugas_uas/widget/drawer.dart';

class ReadingForumFormPage extends StatefulWidget {
  const ReadingForumFormPage({Key? key}) : super(key: key);

  @override
  State<ReadingForumFormPage> createState() => _ReadingForumFormPageState();
}

class _ReadingForumFormPageState extends State<ReadingForumFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _content = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Reading Discussion Form',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const SideDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Title",
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value ?? "";
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _title = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Content",
                    labelText: "Content",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _content = value ?? "";
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _content = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Discussion content cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
<<<<<<< HEAD
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
=======
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
>>>>>>> ec9d68cbcd19aba380f9cb9a4a1857369e52c472
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
<<<<<<< HEAD
                          "http://127.0.0.1:8000/",
=======
                          "http://kindle-kids-d06-tk.pbp.cs.ui.ac.id/reading_forum/",
>>>>>>> ec9d68cbcd19aba380f9cb9a4a1857369e52c472
                          jsonEncode(<String, String>{
                            'title': _title,
                            'content': _content,
                          }),
                        );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Discussion created successfully!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
<<<<<<< HEAD
                            MaterialPageRoute(builder: (context) => Home()),
=======
                            MaterialPageRoute(
                                builder: (context) => const Home()),
>>>>>>> ec9d68cbcd19aba380f9cb9a4a1857369e52c472
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
<<<<<<< HEAD
                              content: Text("An error occurred, please try again."),
=======
                              content:
                                  Text("An error occurred, please try again."),
>>>>>>> ec9d68cbcd19aba380f9cb9a4a1857369e52c472
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
