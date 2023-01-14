import 'package:intl/intl.dart';

class PopulationData{
  int population;
  DateTime date;

  PopulationData({required this.population, required this.date});

  factory PopulationData.fromJson(Map<String, dynamic> json) {
    return PopulationData(
        population: int.parse(json['population']),
        date: DateFormat("yyyy-m-d").parse(json['date'])
    );
  }
}