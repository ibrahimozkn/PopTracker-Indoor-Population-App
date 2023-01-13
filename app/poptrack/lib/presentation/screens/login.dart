import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:poptrack/data/models/failure.dart';
import 'package:poptrack/data/models/user.dart';
import 'package:poptrack/data/repositories/user_repository.dart';
import 'package:poptrack/presentation/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
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

    setState(() {
      _isLoading = false;
    });

    if (pref.getString('token') != null) {
      Navigator.of(context).popAndPushNamed('/home');
    }
  }

  void onLogin() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      setState(() {
        err = "Please fill all the fields";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    dartz.Either<Failure, User> result =
        await UserRepository().login(emailCtrl.text, passwordCtrl.text);

    setState(() {
      _isLoading = false;
    });

    result.fold((l) {
      setState(() {
        err = l.error;
      });
    }, (r) {
      pref.setString('token', r.token);
      pref.setString('role', r.role ?? "admin");

      Navigator.of(context).popAndPushNamed('/home');
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
                title: Text("Login"),
              ),
              body: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
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
                    ElevatedButton(onPressed: onLogin, child: Text("Login")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: Text("Dont have an account?"))
                  ],
                ),
              ),
            ),
          );
  }
}
