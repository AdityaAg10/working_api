import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteData extends StatefulWidget {
  const DeleteData({Key? key});

  @override
  _DeleteDataState createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  String deleteStatus = '';

  Future<void> deleteData() async {
    final url = Uri.parse('https://dummy.restapiexample.com/api/v1/delete/2/');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        setState(() {
          deleteStatus = 'Data deleted successfully';
        });
      } else if (response.statusCode == 301 || response.statusCode == 302) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          final redirectResponse = await http.delete(Uri.parse(redirectUrl));
          if (redirectResponse.statusCode == 200 || redirectResponse.statusCode == 204) {
            setState(() {
              deleteStatus = 'Data deleted successfully';
            });
          } else {
            setState(() {
              deleteStatus = 'Failed to delete data. Status code: ${redirectResponse.statusCode}';
            });
          }
        } else {
          setState(() {
            deleteStatus = 'Failed to delete data. Redirection URL not found.';
          });
        }
      } else {
        setState(() {
          deleteStatus = 'Failed to delete data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        deleteStatus = 'Error occurred while deleting data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete",
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
              onPressed: deleteData,
              child: const Text("Delete Data"),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Delete Status: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: deleteStatus,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
