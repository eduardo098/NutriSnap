import 'package:flutter/material.dart';
import 'models.dart';
import 'details.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList({Key, key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  Future<List> _futureFavorites;

  @override
  void initState() {
    super.initState();
    _futureFavorites = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder(
          future: _futureFavorites,
          builder: (context, snapshot) {
            List content;
            if (snapshot.hasData) {
              content = snapshot.data;
              return content.isEmpty
                  ? Center(child: Text("No has agregado nada a favoritos"))
                  : ListView.builder(
                      itemCount: content.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: ListTile(
                            leading: Image.network(content[index].img),
                            title: Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(content[index].nombre.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700))),
                            subtitle: Text(
                                content[index].descripcion.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.lightGreen[400]),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                nombre: content[index].nombre,
                                descripcion: content[index].descripcion,
                                imgURL: content[index].img,
                                calorias: content[index].calorias,
                                proteina: content[index].proteina,
                                grasas: content[index].grasas,
                                carbs: content[index].carbs,
                              )
                            ));
                            }
                          ),
                        );
                      });
            }
          }),
    ));
  }
}
