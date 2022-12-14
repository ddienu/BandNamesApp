import 'package:flutter/material.dart';

import 'package:band_names_app/src/services/socket_service.dart';
import 'package:provider/provider.dart';

import 'package:band_names_app/src/pages/home_page.dart';
import 'package:band_names_app/src/pages/status.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => SocketService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Band Names App',
        initialRoute: 'home',
        routes: {
          'home':(context) => const HomePage(),
          'status': (context) => const StatusPage()
        },
      ),
    );
  }
}