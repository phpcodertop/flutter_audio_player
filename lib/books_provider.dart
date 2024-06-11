
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BooksProvider with ChangeNotifier {
  List books = [];
  List popularBooks = [];

  readData() {
    rootBundle
        .loadString('json/books.json')
        .then((s) {
        books = jsonDecode(s);
        notifyListeners();
    });

    rootBundle
        .loadString('json/popularBooks.json')
        .then((s) {
        popularBooks = jsonDecode(s);
        notifyListeners();
    });
  }

}