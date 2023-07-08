import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutData extends StatefulWidget {
  const PutData({Key? key});

  @override
  State<PutData> createState() => _PutDataState();
}

class _PutDataState extends State<PutData> {
  final url = "https://dummy.restapiexample.com/api/v1/update/21/";
  String putResponse = '';

  Future<void> putData() async {
    try {
      final response = await http.put(
        Uri.parse(url),
        body: {
          "name": "test",
          "salary": "123",
          "age": "23"
        },
      );

      setState(() {
        putResponse = response.body;
      });
    } catch (e) {
      print('Error occurred while updating data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Put",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                onPressed: putData,
                child: const Text("Put Data"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Put Response:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      putResponse,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
