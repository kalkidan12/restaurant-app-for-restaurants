// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    required this.id,
    required this.tname,
    required this.numSit,
    required this.description,
    required this.isVip,
    required this.image,
    required this.price,
    required this.availble,
  });

  int id;
  String tname;
  String numSit;
  String description;
  bool isVip;
  String image;
  String price;
  bool availble;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        tname: json["tname"],
        numSit: json["numSit"],
        description: json["description"],
        isVip: json["isVIP"],
        image: json["image"],
        price: json["price"],
        availble: json["availble"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tname": tname,
        "numSit": numSit,
        "description": description,
        "isVIP": isVip,
        "image": image,
        "price": price,
        "availble": availble,
      };
}
