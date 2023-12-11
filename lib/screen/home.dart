import "dart:convert";

import "package:flutter/material.dart";
import "package:tugas_uas/widget/drawer.dart";
import "package:tugas_uas/model/book.dart";
import "package:http/http.dart" as http;
import 'package:tugas_uas/utils/titlecase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Book>> getBooks() async {
    // TODO Ganti URL!!!
    const url = "http://127.0.0.1:8000/api/books?page=all";
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> books = [];
    for (var b in data) {
      books.add(Book.fromJson(b));
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Kindle Kids",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      drawer: const SideDrawer(),
      body: FutureBuilder(
        future: getBooks(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       (snapshot.data![index].fields?.title ??
                  //               "loh kok ga ada")
                  //           .toTitleCase(),
                  //       style: const TextStyle(
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 10),
                  //     Text(snapshot.data![index].fields?.downloadCount
                  //             ?.toString() ??
                  //         "NaN"),
                  //     const SizedBox(height: 10),
                  //   ],
                  // ),
                  // use card
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            (snapshot.data![index].fields?.title ??
                                    "loh kok ga ada")
                                .toTitleCase(),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // subtitle: Text(snapshot.data![index].fields?.author ??
                          // "Tidak ada penulis"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
