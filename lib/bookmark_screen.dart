import 'package:flutter/material.dart';
import 'package:library_app/book_item_widget.dart';
import 'package:library_app/super_base.dart';

import 'json/book.dart';

class BookmarkScreen extends StatefulWidget{
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => BookmarkScreenState();
}

class BookmarkScreenState extends Superbase<BookmarkScreen> {

  var list = <Book>[];

  final _key = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      reload();
    });
    super.initState();
  }

  void reload()=>_key.currentState?.show();



  Future<void> loadData()async{
    list = await getBooks();
    setState(() {

    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Theme.of(context).textTheme.headline6?.color
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: const Text("Bookmark"),
      ),
      body: RefreshIndicator(
        key: _key,
        onRefresh: loadData,
        child: ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
          return BookItemWidgetScreen(book: list[index],parentReload: reload,);
        }),
      ),
    );
  }
}