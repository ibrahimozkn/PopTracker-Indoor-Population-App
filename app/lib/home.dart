import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:poptracker/dioclient.dart';
import 'package:poptracker/loading_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentPopulation;
  bool _isLoading = true;
  String loadMsg = "Loading screen";

  @override
  void initState() {
    initScreen();
    super.initState();
  }

  void initScreen() async{
    setState(() {
      _isLoading = true;
      loadMsg = "Loading screen";
    });

    currentPopulation = "0";

    setState(() {
      _isLoading = false;
    });

  }

  void refreshPopulation() async{
    Either<int, String> result = await DioClient.fetchPopulation();

    if(result.isRight){
      currentPopulation = result.right;
    }else{
      currentPopulation = result.left.toString();
    }

  }

  void incrementPopulation() async{

    Either<bool, String> result = await DioClient.incrementPopulation();

    if(result.isRight){
      currentPopulation = result.right;
    }else{
      refreshPopulation();
    }

  }

  void decrementPopulation() async{

    Either<bool, String> result = await DioClient.incrementPopulation();

    if(result.isRight){
      currentPopulation = result.right;
    }else{
      refreshPopulation();
    }

  }


  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingWidget(message: loadMsg) : SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF1F2F6),
        appBar: AppBar(
          actions: [
            //TextButton(onPressed: (){}, child: Text("Refresh Population", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),),
            IconButton(onPressed: refreshPopulation, icon: Icon(Icons.refresh))
          ],
          title: Text("Pop Tracker Demo"),backgroundColor: Color(0xFF758BFD),),
        body: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Current indoor population", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
          Text(currentPopulation, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
          SizedBox(height: 30,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            height: 40.0,
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: incrementPopulation,
              child: Text(
                "+1",
                style: TextStyle(color: Colors.white),
              ),
            )),
            SizedBox(width: 10,),
            Container(
                height: 40.0,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: decrementPopulation,
                  child: Text(
                    "-1",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],)
        ],),),
      ),
    );
  }
}
