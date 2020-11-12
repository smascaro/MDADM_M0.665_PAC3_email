import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymail/screens/details_screen.dart';
import 'package:mymail/screens/list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor _palette = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: _palette,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: ListScreen.routeName,
      routes: {
        ListScreen.routeName: (context) => ListScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen()
      },
    );
  }
}
