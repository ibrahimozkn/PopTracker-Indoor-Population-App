
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

class EditCompanyPage extends StatefulWidget {
  final argument;
  const EditCompanyPage({Key? key, required this.argument}) : super(key: key);

  @override
  State<EditCompanyPage> createState() => _EditCompanyPageState();
}

class _EditCompanyPageState extends State<EditCompanyPage> {
  late Business business;
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  bool _isLoading = false;
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

    business = widget.argument['business']!;

    nameCtrl.text = business.name;
    addressCtrl.text = business.address;

    setState(() {
      _isLoading = false;
    });

  }

  void onEditBusiness() async {
    if (nameCtrl.text.isEmpty || addressCtrl.text.isEmpty) {
      setState(() {
        err = "Please fill all the fields";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    
    var editedBusiness = Business(id: business.id, name: nameCtrl.text, address: addressCtrl.text, coord: "");

    dartz.Either<Failure, bool> result = await BusinessRepository().editBusiness(editedBusiness, pref.getString('token')!);
    

    setState(() {
      _isLoading = false;
    });

    result.fold((l) {
      setState(() {
        err = l.error;
      });
    }, (r) {

      Navigator.of(context).pop(editedBusiness);
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
          title: Text("Edit Business"),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Edit Business",
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
              ElevatedButton(onPressed: onEditBusiness, child: Text("Edit Business")),
            ],
          ),
        ),
      ),
    );
  }
}

