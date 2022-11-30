import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF1F2F6),
        appBar: AppBar(title: Text("Pop Tracker Demo"),backgroundColor: Color(0xFF758BFD),),
        body: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Current indoor population", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
          Text("200", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            height: 40.0,
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: (){},
              child: Text(
                "+1",
                style: Theme.of(context).textTheme.button,
              ),
            )),
            SizedBox(width: 10,),
            Container(
                height: 40.0,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text(
                    "-1",
                    style: Theme.of(context).textTheme.button,
                  ),
                )),
          ],)
        ],),),
      ),
    );
  }
}
