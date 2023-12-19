import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_uas/screen/book_detail.dart';

String title = "";
String tags = "";

class SearchBy extends StatefulWidget {
  const SearchBy({super.key});

  @override
  State<SearchBy> createState() => _SearchByState();
}

class _SearchByState extends State<SearchBy> {
  Map<String, dynamic> booksByTag = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the app starts
  }

  Future<void> fetchData() async {
    // Replace URL with your API endpoint that returns the JSON data
    var apiUrl =
        'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/search-ajax-flutter/';

    var data = {
      'title': title,
      'tags': tags,
    };

    // Make a GET request
    var response = await http.post(
      Uri.parse(apiUrl),
      body: data,
    );

    if (response.statusCode == 200) {
      // If the server returns a successful response, parse the JSON
      var jsonData = json.decode(response.body);
      setState(() {
        booksByTag = Map<String, dynamic>.from(jsonData);
        isLoading = false;
        // print(booksByTag['books']);
      });
    } else {
      // If the server does not return a successful response, throw an error

      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Books by Tag'),
        ),
        body: isLoading ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16), // Adding some space between the CircularProgressIndicator and the text
            Text('Loading data...'),
          ],
        ),
      ):
        ListView.builder(
          itemCount: booksByTag.length,
          itemBuilder: (context, index) {
            // var tag = booksByTag.keys.elementAt(index);
            var books = booksByTag["books"];
            // print(books);
            // var tag = books['fields']['title'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Title: $title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tag: $tags',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: _buildBooksList(books),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildBooksList(List<dynamic> booksInfo) {
    // List<dynamic> books = json.decode(booksInfo);
    return booksInfo.map((bookInfo) {
      Map<String, dynamic> bookFields = bookInfo['fields'];
      return ListTile(
        leading: Image.network(bookFields['cover_url']),
        subtitle: Text('Author: ${bookFields['author']}'),
        title: Text(bookFields['title']),
        onTap: () {
          // Handle book tap
          print('Book tapped: ${bookFields['title']}');
          print(bookFields['cover_url']);
          Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return BookDetail(
                              id: bookInfo['id'],
                            );
                          },
                        ));
        },
      );
    }).toList();
  }
}
