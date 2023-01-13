class Business{
  int? id;
  String name;
  String address;
  String coord;
  int? populationId;

  Business({this.id, required this.name, required this.coord, required this.address, this.populationId});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      coord: json['coordinates'] as String,
      populationId: json['population_id'] as int
    );
  }

}