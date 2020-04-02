import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class Item {
  String calorias;
  String carbs;
  String descripcion;
  String grasas;
  String img;
  String nombre;
  String proteina;

  Item(
      {this.calorias,
      this.carbs,
      this.descripcion,
      this.grasas,
      this.img,
      this.nombre,
      this.proteina});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      calorias: json['calorias'],
      carbs: json['carbs'],
      descripcion: json['descripcion'],
      grasas: json['grasas'],
      img: json['img'],
      nombre: json['nombre'] as String,
      proteina: json['proteina'],
    );
  }

  Map toJson() {
    var data = new Map<String, dynamic>();
    data["calorias"] = calorias;
    data["carbs"] = carbs;
    data["descripcion"] = descripcion;
    data["grasas"] = grasas;
    data["img"] = img;
    data["nombre"] = nombre;
    data["proteina"] = proteina;
    return data;
  }
}

String API_URL = "http://35.243.132.64:3000";

Future<List> getFavorites() async {
  final response = await http.get(API_URL + "/items");
  if (response.statusCode == 200) {
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    return items.map((data) => Item.fromJson(data)).toList();
  } else {
    throw Exception('Failed to get users');
  }
}

Future<Item> addToFavorites(Item item) async {
  return http
      .post(API_URL + "/items",
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "img": item.img.toString(),
            "nombre": item.nombre.toString(),
            "descripcion": item.descripcion.toString(),
            "calorias": item.calorias.toString(),
            "proteina": item.proteina.toString(),
            "carbs": item.carbs.toString(),
            "grasas": item.grasas.toString(),
          }))
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("STATUS CODE::: " + statusCode.toString());
      throw new Exception("Error");
    } else {
      print(json.decode(response.body));
    }
  });
}
