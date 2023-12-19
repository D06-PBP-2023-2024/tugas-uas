import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TagFormPage extends StatefulWidget {
  const TagFormPage({super.key, required this.id});
  final int id;

  @override
  State<TagFormPage> createState() => _TagFormPageState();
}

class _TagFormPageState extends State<TagFormPage> {
  String subject = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Tag"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
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
                  subject = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                http.post(
                  Uri.parse(
                      "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/api/books/${widget.id}/tags"),
                  headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                  },
                  body: jsonEncode(<String, String>{
                    "subject": "subject",
                  }),
                );
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
    );
  }
}
