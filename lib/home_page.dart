import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_view_rest_api/urls.dart';
import 'package:http/http.dart' as http;
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List data;
  bool isLoading = true, isOffline = false;

  Future<String> getData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOffline = true;
        isLoading = false;
      });
      return "No Internet Connection!";
    }
    var response = await http
        .get(Uri.parse(postUrl), headers: {"Accept": "application/json"});
    setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Posts"),
      ),
      body: isOffline
          ? const Center(child: Text("No Internet Connection!"))
          : isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            data[index]["title"],
                            textAlign: TextAlign.justify,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  postId: data[index]["id"],
                                ),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 2.0,
                        )
                      ],
                    );
                  },
                ),
    );
  }
}
