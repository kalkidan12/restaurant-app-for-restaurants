import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    required this.refresh,
    required this.access,
  });

  String refresh;
  String access;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}

UserRegister userRegisterFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  UserRegister({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.userType,
  });

  int id;
  String username;
  String email;
  String password;
  dynamic userType;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "user_type": userType,
      };
}

UserContinueRegister userContinueRegisterFromJson(String str) =>
    UserContinueRegister.fromJson(json.decode(str));

String userContinueRegisterToJson(UserContinueRegister data) =>
    json.encode(data.toJson());

class UserContinueRegister {
  UserContinueRegister({
    required this.restaurantId,
    required this.userId,
    required this.name,
    required this.mapLink,
    required this.location,
    required this.phoneNumber,
  });

  int restaurantId;
  int userId;
  String name;
  String mapLink;
  String location;
  String phoneNumber;

  factory UserContinueRegister.fromJson(Map<String, dynamic> json) =>
      UserContinueRegister(
        restaurantId: json["restaurant_id"],
        userId: json["user_id"],
        name: json["name"],
        mapLink: json["map_link"],
        location: json["location"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "user_id": userId,
        "name": name,
        "map_link": mapLink,
        "location": location,
        "phone_number": phoneNumber,
      };
}
