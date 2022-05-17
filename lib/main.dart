import 'package:flutter/material.dart';
import 'package:places/screen/place_form_screen.dart';
import 'package:places/screen/places_list_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final theme = ThemeData(
    primarySwatch: Colors.indigo,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Great Places',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(),
      ),
      home: const PlacesListScreen(),
      routes: {
        AppRoutes.PLACE_FORM: (context) => const PlaceFormScreen(),
      },
    );
  }
}
