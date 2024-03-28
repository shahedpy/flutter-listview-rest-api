import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.postId});

  final int postId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Map<String, dynamic> postData;

  Future<void> getData() async {
    var response = await http.get(
        Uri.parse(
            "https://jsonplaceholder.typicode.com/posts/${widget.postId}"),
        headers: {"Accept": "application/json"});

    setState(() {
      postData = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(postData['title']),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(postData['body'])),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
