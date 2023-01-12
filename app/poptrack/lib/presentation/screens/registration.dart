import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:poptrack/data/models/failure.dart';
import 'package:poptrack/data/models/user.dart';
import 'package:poptrack/data/repositories/user_repository.dart';
import 'package:poptrack/presentation/widgets/input_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  bool _isLoading = false;

  String err = "";

  void onRegister() async {
    if (emailCtrl.text.isEmpty ||
        nameCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty) {
      setState(() {
        err = "Please fill all the fields";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    User user = new User(
        token: "",
        email: emailCtrl.text,
        name: nameCtrl.text,
        password: passwordCtrl.text);

    dartz.Either<Failure, bool> result = await UserRepository().register(user);

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
                title: Text("Register"),
              ),
              body: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
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
                        icon: Icons.account_circle,
                        action: TextInputAction.next,
                        onTap: () {}),
                    InputWidget(
                        controller: emailCtrl,
                        label: "Email",
                        onChanged: (s) {},
                        icon: Icons.email,
                        action: TextInputAction.next,
                        onTap: () {}),
                    InputWidget(
                        controller: passwordCtrl,
                        label: "Password",
                        obsecure: true,
                        onChanged: (s) {},
                        icon: Icons.password,
                        action: TextInputAction.next,
                        onTap: () {}),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: onRegister, child: Text("Register")),
                  ],
                ),
              ),
            ),
          );
  }
}
