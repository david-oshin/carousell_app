import 'package:carousell_sample/carousell_image/view/carousell_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousell Demo',
      home: CarousellImagePage(),
    );
  }
}

