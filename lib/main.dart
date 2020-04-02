import 'package:flutter/material.dart';
import 'home.dart';
import 'favorites.dart';

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.lightGreen[400],
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home, color: Colors.lightGreen[900],)),
                Tab(icon: Icon(Icons.favorite, color: Colors.lightGreen[900]))
              ],
            ),
            title: Text('Nutrisnap', style: TextStyle(color: Colors.white),),
          ),
          body: TabBarView(
            children: <Widget>[
              HomeScreen(),
              FavoriteList(),
            ],
          ),
        ),
      )
    );
  }
}

void main() => runApp(CameraApp());