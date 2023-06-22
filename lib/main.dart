import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_ratings/bloc/star_handling_bloc.dart';
import 'package:star_ratings/screens/rating_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: "Lato",
      ),
      home: BlocProvider(
        create: (context) => StarHandlingBloc(),
        child: const RatingPage(),
      ),
    );
  }
}
