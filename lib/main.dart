import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/router/routers.dart';
import 'package:naqsh_agent/src/ui/language/language_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NaqshApp());
}

class NaqshApp extends StatelessWidget {
   NaqshApp({super.key});
  final _route = RouterGenerator();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: _route.onGenerator,
    );
  }
}

