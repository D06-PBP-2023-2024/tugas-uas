import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/screen/readingforum_page.dart';
import 'package:tugas_uas/widget/drawer.dart';

class ReplyForm extends StatefulWidget {
  const ReplyForm({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<ReplyForm> createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  final _formKey = GlobalKey<FormState>();
  String _content = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Reply Form',
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
                      return "Reply content cannot be empty!";
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
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/reading_forum/create_reply_flutter/${widget.id}/',
                          jsonEncode(<String, String>{
                            'content': _content,
                          }),
                        );
                        if (response['success'] ==
                                'Discussion created successfully.' &&
                            context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Reply created successfully!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReadingForumPage()),
                          );
                        } else if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("An error occurred, please try again."),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Reply",
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
