import 'dart:convert';

Inventory inventoryFromJson(String str) => Inventory.fromJson(json.decode(str));

String inventoryToJson(Inventory data) => json.encode(data.toJson());

class Inventory {
  Inventory({
    required this.inventoryId,
    required this.inventoryName,
    required this.quantity,
    required this.measurement,
    required this.noticeIfBelow,
    required this.createdOn,
    required this.updatedOn,
    required this.updateRemark,
    required this.restaurant,
  });

  int inventoryId;
  String inventoryName;
  int quantity;
  String measurement;
  int noticeIfBelow;
  DateTime createdOn;
  DateTime updatedOn;
  String updateRemark;
  int restaurant;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        inventoryId: json["inventory_id"],
        inventoryName: json["inventory_name"],
        quantity: json["quantity"],
        measurement: json["measurement"],
        noticeIfBelow: json["notice_if_below"],
        createdOn: DateTime.parse(json["createdOn"]),
        updatedOn: DateTime.parse(json["updatedOn"]),
        updateRemark: json["update_remark"],
        restaurant: json["restaurant"],
      );

  Map<String, dynamic> toJson() => {
        "inventory_id": inventoryId,
        "inventory_name": inventoryName,
        "quantity": quantity,
        "measurement": measurement,
        "notice_if_below": noticeIfBelow,
        "createdOn": createdOn.toIso8601String(),
        "updatedOn": updatedOn.toIso8601String(),
        "update_remark": updateRemark,
        "restaurant": restaurant,
      };
}
