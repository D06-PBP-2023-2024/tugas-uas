import 'package:flutter/material.dart';
import 'package:tugas_uas/groupby.dart';
import 'package:tugas_uas/search.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _StatePageState();
}

class _StatePageState extends State<FilterPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Filter Search'),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      labelText: 'Tags',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Process or save the title and tags data here

                      print('Pressed Group by Tags');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GroupBy()));
                    },
                    child: const Text('Group by Tags'),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Process or save the title and tags data here
                      title = _titleController.text;
                      tags = _tagsController.text;
                      // You can perform actions with the title and tags data
                      // For example, print the values to the console
                      print('Title: $title');
                      print('Tags: $tags');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchBy()));
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}
