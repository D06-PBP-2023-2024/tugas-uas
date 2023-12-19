import 'package:flutter/material.dart';
import 'package:tugas_uas/screen/home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  final Key? key;
  @override
  _CommentPageState createState() => _CommentPageState();

  const CommentPage({this.key}) : super(key: key);
}

class _CommentPageState extends State<CommentPage> {
  final _formKey = GlobalKey<FormState>();
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitur Komentar'),
      ),
      body: Column(
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
                  _comment = value ?? "";
                });
              },
              onSaved: (String? value) {
                setState(() {
                  _comment = value ?? "";
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Comment content cannot be empty!";
                }
                return null;
              },
            ),
          ),
          // Buttonnya untuk submit
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
                    print("before making request");
                    final response = await request.post(
                      "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/main/comment-flutter/",
                      {
                        'comment': _comment,
                      },
                    );
                    print("after making request");
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Comment created successfully!"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("An error occurred, please try again."),
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
    );
  }
}
