import "package:flutter/material.dart";
import "package:tugas_uas/widget/drawer.dart";

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key, required this.bookId}) : super(key: key);
  final int bookId;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Kindle Kids",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
          // child: const Text("$widget.bookId"),
          ),
    );
  }
}
