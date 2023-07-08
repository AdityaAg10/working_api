// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostData extends StatefulWidget {
  const PostData({Key? key});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final url = "https://dummy.restapiexample.com/api/v1/create";
  String postResponse = '';

  Future<void> postData() async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "name": "test",
          "salary": "123",
          "age": "23",
        },
      );

      setState(() {
        postResponse = response.body;
      });
    } catch (e) {
      print('Error occurred while sending post data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: postData,
              child: const Text("Send Post"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Post Response:\n',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: postResponse,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
