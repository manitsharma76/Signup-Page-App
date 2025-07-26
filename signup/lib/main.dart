import 'package:flutter/material.dart';
import 'form_page.dart';
import 'view_submissions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form with MySQL',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Fill Form'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => FormPage()));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('View Submitted Data'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ViewSubmissions()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
