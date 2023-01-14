class PopulationData{
  int population;
  String date;

  PopulationData({required this.population, required this.date});

  factory PopulationData.fromJson(Map<String, dynamic> json) {
    return PopulationData(
        population: int.parse(json['population']),
        date: json['date'] as String
    );
  }
}