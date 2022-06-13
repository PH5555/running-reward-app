import 'package:flutter/material.dart';
import 'package:running_reward_app/app.dart';
import 'package:running_reward_app/app_builder.dart';

void main() {
  runApp(AppRebuilder());
}

class AppRebuilder extends StatelessWidget {
  const AppRebuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: App());
    });
  }
}
