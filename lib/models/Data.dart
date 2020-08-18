import 'dart:convert';

class Data {
  int id;
  String name;
  String category;
  int price;
  String img;

  Data({this.id, this.name, this.category, this.price, this.img});

  factory Data.fromJson(Map<String, dynamic> data) {
    return Data(
        id: data['id'],
        name: data['name'],
        category: data['category'],
        price: data['price'],
        img: data['img']);
  }

  Map<String, String> toJson() {
    return {
      "id": "$id",
      "name": name,
      "category": category,
      "price": "$price",
      img: img
    };
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $name, category: $category, price: $price, img: $img}';
  }
}

List<Data> dataFromJson(String jsonData) {
  final response = json.decode(jsonData);
  return List<Data>.from(response['data'].map((data) => Data.fromJson(data)));
}

String dataToJson(Data data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
