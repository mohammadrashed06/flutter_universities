import 'package:flutter/material.dart';
import 'bloc_state/universities_block.dart';
import 'package:flutter_api_with_bloc/repositories/universities_repository.dart';
import 'package:flutter_api_with_bloc/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MyApp()
  );
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }

}

class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    //To Communicate UI with Service layer
    return MaterialApp(
      home: BlocProvider(create: (context)=>UniversitiesBloc(universitiesRepository: UniversitiesRepository()),
          child:HomeScreen()),
    );
  }

}


