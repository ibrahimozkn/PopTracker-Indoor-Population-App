
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:poptrack/data/models/failure.dart';
import 'package:poptrack/data/models/user.dart';
import 'package:poptrack/data/repositories/business_repository.dart';
import 'package:poptrack/data/repositories/user_repository.dart';
import 'package:poptrack/presentation/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/business.dart';

class PopulationSimulatorPage extends StatefulWidget {
  const PopulationSimulatorPage({Key? key}) : super(key: key);

  @override
  State<PopulationSimulatorPage> createState() => _PopulationSimulatorPageState();
}

class _PopulationSimulatorPageState extends State<PopulationSimulatorPage> {
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  bool _isLoading = false;
  bool _locationGot = false;
  late LocationData locationData;
  late SharedPreferences pref;


  String err = "";

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
    await getLocation();

    if(!_locationGot){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to get location data"),
        ),
      );
      Navigator.of(context).pop();
    }

    setState(() {
      _isLoading = false;
    });

  }

  Future<bool> getLocation() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      locationData = _locationData;
      _locationGot = true;
    });
    return true;
  }

  void onAddBusiness() async {
    if (nameCtrl.text.isEmpty || addressCtrl.text.isEmpty) {
      setState(() {
        err = "Please fill all the fields";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    
    var business = Business(name: nameCtrl.text, address: addressCtrl.text, coord: locationData.longitude.toString() + "," + locationData.latitude.toString());

    dartz.Either<Failure, bool> result = await BusinessRepository().addBusiness(business, pref.getString('token')!);
    

    setState(() {
      _isLoading = false;
    });

    result.fold((l) {
      setState(() {
        err = l.error;
      });
    }, (r) {

      Navigator.of(context).pop();
    });
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
          title: Text("Add Business"),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Business",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                err,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.red),
              ),
              InputWidget(
                  controller: nameCtrl,
                  label: "Name",
                  onChanged: (s) {},
                  icon: Icons.drive_file_rename_outline,
                  action: TextInputAction.next,
                  onTap: () {}),
              InputWidget(
                  controller: addressCtrl,
                  label: "Address",
                  onChanged: (s) {},
                  icon: Icons.location_on,
                  action: TextInputAction.next,
                  onTap: () {}),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: onAddBusiness, child: Text("Add Business")),
            ],
          ),
        ),
      ),
    );
  }
}

