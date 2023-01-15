import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poptrack/data/models/failure.dart';
import 'package:poptrack/data/models/population_data.dart';
import 'package:poptrack/data/repositories/business_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../data/models/business.dart';

class CompanyInfoPage extends StatefulWidget {
  final argument;
  const CompanyInfoPage({Key? key, required this.argument}) : super(key: key);

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  late SharedPreferences pref;
  bool _simActive = false;
  late Business business;
  late List<PopulationData> populationDatas;
  late int count;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initScreen();
  }

  @override
  void dispose() {
    _simActive = false;
    super.dispose();
  }

  void initScreen() async {
    setState(() {
      _isLoading = true;
    });
    pref = await SharedPreferences.getInstance();

    business = widget.argument['company'];

    updateCount();

    dartz.Either<Failure, List<PopulationData>> result2 =
        await BusinessRepository()
            .getPopulationHistory(business.id!, pref.getString('token')!);

    result2.fold((l) => populationDatas = [], (r) => populationDatas = r);


    setState(() {
      _isLoading = false;
    });
  }

  void updateCount() async {
    dartz.Either<Failure, int> result = await BusinessRepository()
        .getPopulation(business.id!, pref.getString('token')!);

    result.fold((l) {
      setState(() {
        count = 0;
      });
    }, (r) {
      setState(() {
        count = r;
      });
    });
  }

  int PoissonSmall(double lambda) {
    // Algorithm due to Donald Knuth, 1969.
    double p = 1.0, L = exp(-lambda);
    int k = 0;
    do {
      k++;
      p *= GetUniform();
    } while (p > L);
    return k - 1;
  }

  double GetUniform() /* generates a 0 ~ Random number between 1 */
  {
    double f;
    f = (Random().nextInt(100) % 100);
    return f / 100;
  }

  void simulate() async {
    setState(() {
      _simActive = !_simActive;
    });

    while (_simActive) {
      int time = PoissonSmall(2);

      print(time);
      var rand = Random().nextInt(2);

      await Future.delayed(Duration(seconds: time));

      if (rand == 0) {
        await BusinessRepository()
            .incrementPopulation(business.id!, pref.getString('token')!);
      } else {
        await BusinessRepository()
            .decrementPopulation(business.id!, pref.getString('token')!);
      }

      updateCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
            appBar: AppBar(
              title: Text(business.name),
              actions: [
                pref.getString('role') == "1"
                    ? IconButton(
                        onPressed: () async {
                          var response = await Navigator.of(context)
                              .pushNamed('/edit_company', arguments: {
                            'business': business,
                          });

                          if (response is Business) {
                            setState(() {
                              business = response;
                            });
                          }
                        },
                        icon: Icon(Icons.edit))
                    : Container(),
                pref.getString('role') == "1"
                    ? IconButton(
                        onPressed: simulate,
                        icon: !_simActive
                            ? Icon(Icons.play_arrow)
                            : Icon(Icons.stop))
                    : Container(),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  children: [
                    Card(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 25.0),
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
                                          "Company Name",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF212121),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Address",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF212121),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          business.name,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xFF212121),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                business.address,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF212121),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    pref.getString('role') == "1"
                                        ? Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/population_history',
                                                          arguments: {
                                                        'business_id':
                                                            business.id,
                                                      });
                                                },
                                                child:
                                                    Text("Population History")))
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Text(
                            count.toString(),
                            style: TextStyle(fontSize: 50),
                          ),
                          Text(
                            "People",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          pref.getString('role') == "1"
                              ? SfCartesianChart(
                                  // Initialize category axis
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries<PopulationData, String>>[
                                      // Renders line chart
                                      LineSeries<PopulationData, String>(
                                          dataSource: populationDatas,
                                          xValueMapper:
                                              (PopulationData data, _) =>
                                                  DateFormat("dd/mm/yyyy")
                                                      .format(data.date),
                                          yValueMapper:
                                              (PopulationData data, _) =>
                                                  data.population)
                                    ]
                                  /*series: <LineSeries<PopulationData, String>>[
                                LineSeries<PopulationData, DateTime>(
                                    // Bind data source
                                    dataSource: populationDatas,
                                    xValueMapper: (PopulationData data, _) =>
                                        data.date,
                                    yValueMapper: (PopulationData data, _) =>
                                        data.population)
                              ]*/
                                  )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
  }
}
