import 'package:flutter/material.dart';
import 'package:library_app/book_item_widget.dart';
import 'package:library_app/super_base.dart';

import 'json/book.dart';

class BorrowedBookScreen extends StatefulWidget{
  const BorrowedBookScreen({Key? key}) : super(key: key);

  @override
  State<BorrowedBookScreen> createState() => BorrowedBookScreenState();
}

class BorrowedBookScreenState extends Superbase<BorrowedBookScreen> {

  var list = <Book>[];

  final _key = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      reload();
    });
    super.initState();
  }

  void reload()=>_key.currentState?.show();



  Future<void> loadData()async{
    return ajax(url: "BorrowedUserBooks",method: "POST",onValue: (s,v){

      setState(() {
        list = (s['BooksBorrowed'] as Iterable).map((e) => Book.fromJson(e)).toList();
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
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: const Text("Borrowed Books"),
      ),
      body: RefreshIndicator(
        key: _key,
        onRefresh: loadData,
        child: ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
          return BookItemWidgetScreen(book: list[index],parentReload: reload,hideFavIcon: true,);
        }),
      ),
    );
  }
}