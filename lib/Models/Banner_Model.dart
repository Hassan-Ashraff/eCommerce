
class BannerModel {
  late final bool status;
  final dynamic message;
  final List<Data> data;

  BannerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    status: json["status"],
    message: json["message"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  final int id;
  final String image;
  final dynamic category;
  final dynamic product;

  Data({
    required this.id,
    required this.image,
    required this.category,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    image: json["image"],
    category: json["category"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "category": category,
    "product": product,
  };
}
