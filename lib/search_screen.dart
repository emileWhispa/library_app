import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/book_item_widget.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/super_base.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends Superbase<SearchScreen> {
  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.query != widget.query && widget.query.isNotEmpty) {
      search();
    }
  }

  bool searching = false;

  List<Book> _list = [];

  Future<void> search() async {
    setState(() {
      searching = true;
    });
    await ajax(
        url: "SearchBooks",
        method: "POST",
        data: FormData.fromMap({"book_name":widget.query}),
        onValue: (object, url) {
          setState(() {
            searching = false;
            _list = (object['BooksInfo'] as Iterable)
                .map((e) => Book.fromJson(e))
                .toList();
          });
        });

    setState(() {
      searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: searching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                var product = _list[index];
                return BookItemWidgetScreen(book: product);
              }),
    );
  }
}
