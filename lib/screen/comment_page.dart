import 'package:flutter/material.dart';
import 'package:tugas_uas/screen/home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  final int id;
  const CommentPage({Key? key, required this.id}) : super(key: key);

  @override
  CommentPageState createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {
  final _formKey = GlobalKey<FormState>();
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitur Komentar'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Comment",
                labelText: "Comment",
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
                    final response = await request.post(
                      "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/comment-flutter/${widget.id}/",
                      {
                        'comment': _comment,
                      },
                    );
                    if (response['status'] == 'success' && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Comment created successfully!"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } else if (context.mounted) {
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
