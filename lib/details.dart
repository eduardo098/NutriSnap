import 'package:flutter/material.dart';
import 'models.dart';
import 'dart:convert';

class DetailsPage extends StatelessWidget {
  String imgURL;
  String nombre;
  String descripcion;
  String carbs;
  String calorias;
  String grasas;
  String proteina;

  DetailsPage(
      {this.imgURL,
      this.nombre,
      this.descripcion,
      this.carbs,
      this.calorias,
      this.grasas,
      this.proteina});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalles"),
          backgroundColor: Colors.lightGreen[400],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  new Container(
                    padding: EdgeInsets.zero,
                    child: Image.network(imgURL),
                  ),
                  Positioned(
                      right: 15.0,
                      bottom: 0.0,
                      child: new FloatingActionButton(
                          child: const Icon(Icons.favorite),
                          backgroundColor: Colors.lightGreen,
                          onPressed: () {
                            Item item = new Item (
                              nombre: this.nombre.toString(),
                              descripcion: this.descripcion.toString(),
                              calorias: this.calorias.toString(),
                              proteina: this.proteina.toString(),
                              carbs: this.carbs.toString(),
                              grasas: this.grasas.toString(),
                              img: this.imgURL,
                            );
                            addToFavorites(item);
                          }))
                ]),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("Nombre",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  subtitle: Text(nombre.toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("Descripcion",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  subtitle: Text(descripcion,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Información Nutricional",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        color: Colors.lightGreen[200],
                        child: ListTile(
                          title: Text("Calorias", style: TextStyle(fontSize: 18)),
                          trailing: Text(calorias + " Kcal.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      Card(
                        color: Colors.lightGreen,
                        child: ListTile(
                          title: Text("Carbohidratos",
                              style: TextStyle(fontSize: 18)),
                          trailing: Text(carbs + " grs.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      Card(
                        color: Colors.lightGreen[200],
                        child: ListTile(
                          title: Text("Grasas", style: TextStyle(fontSize: 18)),
                          trailing: Text(grasas + " grs.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      Card(
                        color: Colors.lightGreen,
                        child: ListTile(
                          title:
                              Text("Proteínas", style: TextStyle(fontSize: 18)),
                          trailing: Text(proteina + " grs.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                ))
              ],
            ),
          ),
        ));
  }
}

