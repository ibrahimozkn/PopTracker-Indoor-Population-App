import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:poptrack/data/models/population_data.dart';
import 'package:poptrack/data/repositories/business_repository.dart';
import 'package:poptrack/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/business.dart';
import '../../data/models/failure.dart';

class PopulationHistoryPage extends StatefulWidget {
  final argument;
  const PopulationHistoryPage({Key? key, required this.argument}) : super(key: key);

  @override
  State<PopulationHistoryPage> createState() => _PopulationHistoryPageState();
}

class _PopulationHistoryPageState extends State<PopulationHistoryPage> {
  late SharedPreferences pref;
  bool _isLoading = false;

  late List<PopulationData> populationHistory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initScreen();
  }

  void initScreen() async {
    setState(() {
      _isLoading = true;
    });

    pref = await SharedPreferences.getInstance();


    dartz.Either<Failure, List<PopulationData>> result = await BusinessRepository().getPopulationHistory(widget.argument['business_id']!, pref.getString('token')!);

    result.fold((l) => populationHistory = [], (r) => populationHistory = r);


    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator(),) : SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Population History"),
        actions: [
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: populationHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 18.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    populationHistory[index].population.toString(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF212121),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    populationHistory[index].date,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF212121),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    ));
  }
}
