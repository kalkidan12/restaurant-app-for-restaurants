import 'dart:convert';

MenuModel MenuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String MenuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  String id;
  String image;
  String name;
  String description;
  int price;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
      };
}
