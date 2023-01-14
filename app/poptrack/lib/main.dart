import 'package:flutter/material.dart';
import 'package:poptrack/presentation/screens/add_business.dart';
import 'package:poptrack/presentation/screens/company_info.dart';
import 'package:poptrack/presentation/screens/edit_company.dart';
import 'package:poptrack/presentation/screens/home.dart';
import 'package:poptrack/presentation/screens/login.dart';
import 'package:poptrack/presentation/screens/population_history.dart';
import 'package:poptrack/presentation/screens/registration.dart';

void main() {
  runApp(const PopTracker());
}

class PopTracker extends StatelessWidget {
  const PopTracker({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegistrationPage(),
        '/add_business': (context) => AddBusinessPage(),
        '/edit_company': (context) => EditCompanyPage(argument: ModalRoute.of(context)!.settings.arguments),
        '/company_info': (context) => CompanyInfoPage(argument: ModalRoute.of(context)!.settings.arguments),
        '/population_history': (context) => PopulationHistoryPage(argument: ModalRoute.of(context)!.settings.arguments),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
