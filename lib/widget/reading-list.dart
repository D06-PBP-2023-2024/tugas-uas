import 'package:flutter/material.dart';

class ReadingList extends StatefulWidget {
  // final int id;

  const ReadingList({super.key});

  @override
  _ReadingListState createState() => _ReadingListState();
}

class _ReadingListState extends State<ReadingList> {
  List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookCard(book: books[index]);
      },
    );
  }
}

class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.author),
        // Add more details or actions as needed
      ),
    );
  }
}
