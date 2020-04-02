import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'details.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}
 
class MyImagePickerState extends State {

  final databaseReference = FirebaseDatabase.instance.reference();

  File imageURI;
 
  Future getImageFromCamera() async {
 
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
 
    setState(() {
      imageURI = image;
    });
  }

  Future getImageFromGallery() async {
 
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
 
    setState(() {
      imageURI = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: imageURI == null ? Icon(Icons.broken_image, size: 300.0, color: Colors.lightGreen) : 
            Image.file(imageURI, fit: BoxFit.fill),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Escanear"),
            onPressed: imageURI == null ? null : () => makeAPICall(),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
            color: Colors.lightGreen
          )
        ],),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen[400],
        icon: Icon(Icons.camera),
        label: Text("Capturar Imagen"),
        onPressed: () => _showDialog(),
      ),
    );
    
  }

  Future<String> makeAPICall() {
    String API_KEY = 'a45a4541f88a40879187e948ba40f5d8';
    String URL = 'https://api.clarifai.com/v2/models/bd367be194cf45149e75f01d59f77ba7/outputs';

    String base64Image = base64Encode(imageURI.readAsBytesSync());
    return http.post(URL, headers: {'Authorization' : 'Key $API_KEY'}, body: jsonEncode(
    {
      "inputs": [
        {
          "data": {
            "image": {
              "base64": "$base64Image"
            }
          }
        }
      ]
    })).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      } else {
        final decoded = json.decode(response.body) as Map;
        final outputs = decoded['outputs'] as List;
        final data = outputs[0]['data']['concepts'][0]['name'];
        print(data);
        getData(data.toString());
        //Navigator.push(context, MaterialPageRoute(builder: (context) => UsersList()));
      }
    });
  }

  void getData(String value){
    databaseReference.child("items").orderByChild('nombre').equalTo(value).once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');

      Map<dynamic, dynamic> l = snapshot.value;

      var s = l.values.toList();

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(
        imgURL: s[0]["img"],
        nombre: s[0]["nombre"],
        descripcion: s[0]["descripcion"],
        calorias: s[0]["calorias"],
        proteina: s[0]["proteina"],
        carbs: s[0]["carbs"],
        grasas: s[0]["grasas"],
      )));

      print(s[0]["carbs"]);
      print(s[0]["proteina"]);

      /*
      for(int i = 0; i < l.length; i++) {
        print(l.values.);
      }
      */
    });
  }

   void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Elige una opción"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Tomar foto"),
              onPressed: () {
                getImageFromCamera();
              },
            ),
            new FlatButton(
              child: new Text("Elegir una foto de la galería"),
              onPressed: () {
                getImageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

}
