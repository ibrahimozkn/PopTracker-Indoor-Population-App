import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:poptrack/data/models/failure.dart';
import 'package:poptrack/data/models/population_data.dart';
import 'package:poptrack/data/repositories/business_repository.dart';
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
  late Business business;
  late int count;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initScreen();
  }

  void initScreen() async{
    setState(() {
      _isLoading = true;
    });

    business = widget.argument['company'];

    dartz.Either<Failure, int> result = await BusinessRepository().getPopulation(business.populationId!);

    result.fold((l) => count = 0, (r) => count = r);


    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator(),) : SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(business.name),
        actions: [IconButton(onPressed: () async{
          var response = await Navigator.of(context).pushNamed('/edit_company', arguments: {
            'business': business,
          });

          if(response is Business){
            setState(() {
              business = response;
            });
          }

        }, icon: Icon(Icons.edit))],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Card(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  business.name,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Population History"))),
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
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                SfCartesianChart(
                  // Initialize category axis
                    primaryXAxis: CategoryAxis(),

                    series: <LineSeries<PopulationData, String>>[
                      LineSeries<PopulationData, String>(
                        // Bind data source
                          dataSource:  <PopulationData>[
                            PopulationData(date: 'Jan', population: 35),
                            PopulationData(date: 'Feb', population: 28),
                            PopulationData(date: 'Mar', population: 34),
                            PopulationData(date: 'Apr', population: 32),
                            PopulationData(date: 'May', population: 40)
                          ],
                          xValueMapper: (PopulationData sales, _) => sales.date,
                          yValueMapper: (PopulationData sales, _) => sales.population
                      )
                    ]
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
