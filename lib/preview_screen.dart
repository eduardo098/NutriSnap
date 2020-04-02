import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:convert';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            SizedBox(height: 10.0),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: RaisedButton(
                  onPressed: () {
                    File imageFile = new File(widget.imagePath);
                    List<int> imageBytes = imageFile.readAsBytesSync();
                    String base64Image = base64Encode(imageBytes);
                    makeAPICall(base64Image);
                  },
                  child: Text('Share'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }

  Future<String> makeAPICall(String data) {
    String API_KEY = 'a45a4541f88a40879187e948ba40f5d8';
    return http.post(url, headers: {'Authorization' : 'Key $API_KEY'}, body: jsonEncode(
    {
      "inputs": [
        {
          "data": {
            "image": {
              "base64": "$data"
            }
          }
        }
      ]
    })).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    } else {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => UsersList()));
    }
  });
  }
}
