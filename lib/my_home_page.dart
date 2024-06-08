import 'dart:convert';

import 'package:ebook_app/app_colors.dart';
import 'package:ebook_app/books_provider.dart';
import 'package:ebook_app/components/home_menu.dart';
import 'package:ebook_app/components/home_tabs.dart';
import 'package:ebook_app/components/popular_books.dart';
import 'package:ebook_app/components/single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<BooksProvider>().readData(context);
  }

  @override
  Widget build(BuildContext context) {
    books = context.read<BooksProvider>().books;
    popularBooks = context.read<BooksProvider>().popularBooks;

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const HomeMenu(),
              const SizedBox(
                height: 20,
              ),
              PopularBooks(books: popularBooks),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      HomeTabs(tabController: _tabController),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, i) {
                          final book = books[i];
                          return SingleListItem(
                            book: book,
                          );
                        },
                      ),
                      const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Content'),
                        ),
                      ),
                      const Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Content'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
