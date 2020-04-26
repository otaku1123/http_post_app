import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Post app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: ChangeForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeForm extends StatefulWidget {
  @override
  ChangeFormState createState() => ChangeFormState();
}

class ChangeFormState extends State<ChangeForm> {
  String text = "";

  void handleText(String e) {
    setState(() {
      text = e;
    });
  }

  void _handlePressed() {
    setState(() {
      // debugPrint(text);
      getPosts();
    });
  }

  Future<http.Response> getPosts() async {
    // var client = http.Client();
    try {
      // final urlResponse = await client.post(text);
      final urlResponse = await http.get(text);
      debugPrint('Response status: ${urlResponse.statusCode}');
      debugPrint('Response body: ${urlResponse.body}');
    } catch (e) {
      print('Error: $e');
    } finally {
      // debugPrint(urlResponse);
      // client.close();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Text("$text",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500)),
          new TextField(
            enabled: true,
            maxLength: 10,
            maxLengthEnforced: false,
            style: TextStyle(color: Colors.red),
            obscureText: false,
            maxLines: 1,
            onChanged: handleText,
          ),
          FlatButton(
            onPressed: _handlePressed,
            color: Colors.blue,
            child: Text(
              'GET',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
