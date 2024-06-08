
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class BooksProvider with ChangeNotifier {
  List books = [];
  List popularBooks = [];

  readData(context) {
    DefaultAssetBundle.of(context)
        .loadString('json/books.json')
        .then((s) {
        books = jsonDecode(s);
        notifyListeners();
    });

    DefaultAssetBundle.of(context)
        .loadString('json/popularBooks.json')
        .then((s) {
        popularBooks = jsonDecode(s);
        notifyListeners();
    });
  }

}