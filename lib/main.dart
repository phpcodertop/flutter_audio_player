import 'package:ebook_app/books_provider.dart';
import 'package:ebook_app/details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Ebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<BooksProvider>(
        create: (BuildContext context) => BooksProvider()..readData(),
        builder: (context, child) {
          return const MyHomePage();
        },
      ),
    );
  }
}
