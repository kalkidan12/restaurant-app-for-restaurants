import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.count,
    required this.results,
    required this.next,
    required this.previous,
  });

  String count;
  List<Result> results;
  String next;
  String previous;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "next": next,
        "previous": previous,
      };
}

class Result {
  Result({
    required this.customerName,
    required this.bookedTable,
    required this.dish,
    required this.orderId,
    required this.quantity,
    required this.totalPrice,
    required this.specialRequests,
    required this.orderStatus,
    required this.waitTime,
    required this.isTakeaway,
    required this.createdOn,
  });

  String customerName;
  BookedTable bookedTable;
  List<Dish> dish;
  String orderId;
  String quantity;
  String totalPrice;
  String specialRequests;
  String orderStatus;
  String waitTime;
  String isTakeaway;
  String createdOn;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        customerName: json["customer_name"],
        bookedTable: BookedTable.fromJson(json["booked_table"]),
        dish: List<Dish>.from(json["dish"].map((x) => Dish.fromJson(x))),
        orderId: json["order_id"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        specialRequests: json["special_requests"],
        orderStatus: json["order_status"],
        waitTime: json["wait_time"],
        isTakeaway: json["isTakeaway"],
        createdOn: json["createdOn"],
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "booked_table": bookedTable.toJson(),
        "dish": List<dynamic>.from(dish.map((x) => x.toJson())),
        "order_id": orderId,
        "quantity": quantity,
        "total_price": totalPrice,
        "special_requests": specialRequests,
        "order_status": orderStatus,
        "wait_time": waitTime,
        "isTakeaway": isTakeaway,
        "createdOn": createdOn,
      };
}

class BookedTable {
  BookedTable({
    required this.bookingTimeX,
    required this.table,
    required this.restaurant,
    required this.customer,
    required this.bookedId,
    required this.noOfPeoples,
    required this.createdOn,
    required this.isCancelled,
  });

  String bookingTimeX;
  String table;
  String restaurant;
  String customer;
  String bookedId;
  String noOfPeoples;
  String createdOn;
  String isCancelled;

  factory BookedTable.fromJson(Map<String, dynamic> json) => BookedTable(
        bookingTimeX: json["booking_time_x"],
        table: json["table"],
        restaurant: json["restaurant"],
        customer: json["customer"],
        bookedId: json["booked_id"],
        noOfPeoples: json["no_of_peoples"],
        createdOn: json["createdOn"],
        isCancelled: json["isCancelled"],
      );

  Map<String, dynamic> toJson() => {
        "booking_time_x": bookingTimeX,
        "table": table,
        "restaurant": restaurant,
        "customer": customer,
        "booked_id": bookedId,
        "no_of_peoples": noOfPeoples,
        "createdOn": createdOn,
        "isCancelled": isCancelled,
      };
}

class Dish {
  Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.dishId,
    required this.image,
    required this.isSpecial,
    required this.createdOn,
    required this.updatedOn,
    required this.restaurant,
    required this.isInventorySet,
  });

  String name;
  String description;
  String price;
  String dishId;
  String image;
  String isSpecial;
  String createdOn;
  String updatedOn;
  String restaurant;
  String isInventorySet;

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        dishId: json["dish_id"],
        image: json["image"],
        isSpecial: json["isSpecial"],
        createdOn: json["createdOn"],
        updatedOn: json["updatedOn"],
        restaurant: json["restaurant"],
        isInventorySet: json["isInventorySet"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "dish_id": dishId,
        "image": image,
        "isSpecial": isSpecial,
        "createdOn": createdOn,
        "updatedOn": updatedOn,
        "restaurant": restaurant,
        "isInventorySet": isInventorySet,
      };
}
