import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_uas/screen/book_detail.dart';

class TagFormPage extends StatefulWidget {
  const TagFormPage({super.key, required this.id});
  final int id;

  @override
  State<TagFormPage> createState() => _TagFormPageState();
}

class _TagFormPageState extends State<TagFormPage> {
  String _subject = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Tag"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Subject",
                ),
                onChanged: (value) {
                  setState(() {
                    _subject = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _subject = value ?? "";
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Processing Data"),
                      ),
                    );
                    final response = await http.post(
                      Uri.parse(
                          "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/create-tag-flutter/${widget.id}"),
                      headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode(<String, String>{
                        "subject": _subject,
                      }),
                    );
                    final dynamic success =
                        jsonDecode(response.body)["success"];
                    if (success == true && context.mounted) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return BookDetail(id: widget.id);
                        },
                      ));
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to add tag!"),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill the form correctly!"),
                      ),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
