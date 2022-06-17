import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/book_item_widget.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/json/category.dart';
import 'package:library_app/super_base.dart';

class CategoryBookScreen extends StatefulWidget {
  final Category category;

  const CategoryBookScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryBookScreen> createState() => _CategoryBookScreenState();
}

class _CategoryBookScreenState extends Superbase<CategoryBookScreen> {
  List<Book> _list = [];

  final _key = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _key.currentState?.show();
    });
    super.initState();
  }

  Future<void> loadData() {
    return ajax(
        url: "BooksByCategory",
        method: "POST",
        data: FormData.fromMap({"book_category_id": widget.category.id}),
        onValue: (object, url) {
          setState(() {
            _list = (object['BooksInfo'] as Iterable?)?.map((e) => Book.fromJson(e)).toList() ?? [];
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Theme.of(context).textTheme.headline6?.color
        ),
        elevation: 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: Text(widget.category.name),),
      body: RefreshIndicator(
        key: _key,
        onRefresh: loadData,
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) =>
                BookItemWidgetScreen(book: _list[index])),
      ),
    );
  }
}
