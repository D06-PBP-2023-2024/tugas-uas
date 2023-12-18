import "package:flutter/material.dart";
import "package:tugas_uas/model/book.dart";
import "package:tugas_uas/widget/drawer.dart";

class BookDetail extends StatelessWidget {
  const BookDetail({super.key, required this.id});
  final int id;

  // Future<Book> getBook() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: const SideDrawer(),
      body: Center(
        child: Text("Detail buku dengan id $id"),
      ),
    );
  }
}
