import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewSubmissions extends StatelessWidget {
  const ViewSubmissions({super.key});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse("http://10.0.2.2/get_submissions.php"));
    final List decoded = json.decode(response.body);
    return decoded.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Submissions")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data;

          if (data == null || data.isEmpty) {
            return Center(child: Text("No submissions found"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final item = data[i];
              return ListTile(
                title: Text(item["name"] ?? "No name"),
                subtitle: Text(
                  "${item["email"] ?? ""} | ${item["phone"] ?? ""} | ${item["gender"] ?? ""} | ${item["dob"] ?? ""}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
