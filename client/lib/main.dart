import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streaming Client',
      home: const StreamListPage(),
    );
  }
}

class StreamListPage extends StatefulWidget {
  const StreamListPage({super.key});

  @override
  State<StreamListPage> createState() => _StreamListPageState();
}

class _StreamListPageState extends State<StreamListPage> {
  List<dynamic> streams = [];

  @override
  void initState() {
    super.initState();
    fetchStreams();
  }

  Future<void> fetchStreams() async {
    final res = await http.get(Uri.parse('http://localhost:8080/streams'));
    if (res.statusCode == 200) {
      setState(() {
        streams = json.decode(res.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams')),
      body: ListView.builder(
        itemCount: streams.length,
        itemBuilder: (context, index) {
          final s = streams[index];
          return ListTile(
            title: Text(s['title'] ?? ''),
            subtitle: Text(s['description'] ?? ''),
          );
        },
      ),
    );
  }
}
