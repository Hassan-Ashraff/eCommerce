class RegistraionResponseModel {
  final bool ? status;
  final String ? message;
  final Data ? data;

  RegistraionResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegistraionResponseModel.fromJson(Map<String, dynamic> json) => RegistraionResponseModel(
    status: json["status"],
    message: json["message"],
    data: json['data'] != null ? Data.fromJson(json["data"]) : null
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String name;
  final String phone;
  final String email;
  final int id;
  final String image;
  final String token;

  Data({
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
    required this.image,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    id: json["id"],
    image: json["image"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "id": id,
    "image": image,
    "token": token,
  };
}
