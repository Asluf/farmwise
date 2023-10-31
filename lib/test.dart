import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  void testing() async {
    try {
      var response =
          await http.get(Uri.parse('http://localhost:5005/getCrops'));
      var jsonresponse = jsonDecode(response.body);
      print(jsonresponse);
    } catch (er) {
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testtt"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("data"),
            ElevatedButton(onPressed: testing, child: Text("Button"))
          ],
        ),
      ),
    );
  }
}
