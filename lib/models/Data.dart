import 'dart:convert';

class Data {
  String joke;

  Data({this.joke});

  factory Data.fromJson(String joke) {
    return Data(joke: joke);
  }

  Map<String, String> toJson() {
    return {"value": joke};
  }

  @override
  String toString() {
    return 'Data{joke: $joke}';
  }
}

List<Data> dataFromJson(String jsonData) {
  final data = json.decode(jsonData);
  print(data);
  return List<Data>.from(
      data['value'].map((data) => Data.fromJson(data['joke'])));
}

String dataToJson(Data data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
