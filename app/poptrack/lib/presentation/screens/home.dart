import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:poptrack/data/repositories/business_repository.dart';
import 'package:poptrack/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/business.dart';
import '../../data/models/failure.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences pref;
  bool _isLoading = false;

  late List<Business> businesses;

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

    dartz.Either<Failure, List<Business>> result = await BusinessRepository().getBusinesses(pref.getString('token')!);

    result.fold((l) => businesses = [], (r) => businesses = r);


    setState(() {
      _isLoading = false;
    });
  }

  void onCompanySelected(int index) {
    //TODO: Open screen
    Navigator.of(context).pushNamed('/company_info', arguments: {
      'company': businesses[index],
    });
  }

  void onCompanyDelete(int index) async{
    setState(() {
      _isLoading = true;
    });
    dartz.Either<Failure, bool> result = await BusinessRepository().deleteBusiness(businesses[index].id!, pref.getString('token')!);


    setState(() {
      _isLoading = false;
    });

    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.error),
        ),
      );
    }, (r) {
      setState(() {
        businesses.removeAt(index);
      });
    });


  }

  void onLogout() {
    UserRepository().logout(pref.getString('token')!);
    pref.remove('token');
    pref.remove('role');
    Navigator.of(context).popAndPushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator(),) : SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          pref.getString('role') == "1"
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add_business');
                  },
                  icon: Icon(Icons.add))
              : Container(),
          IconButton(onPressed: initScreen, icon: Icon(Icons.refresh)),
          IconButton(onPressed: onLogout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: businesses.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => onCompanySelected(index),
                child: Card(
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
                                      businesses[index].name,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF212121),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    pref.getString('role') == "1" ? IconButton(
                                        onPressed: () => onCompanyDelete(index),
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.redAccent,
                                        )) : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
    ));
  }
}
