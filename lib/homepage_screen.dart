import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/book_detail_screen.dart';
import 'package:library_app/book_item_widget.dart';
import 'package:library_app/category_screen.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/json/user.dart';
import 'package:library_app/super_base.dart';

import 'json/category.dart';

class HomepageScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends Superbase<HomepageScreen> {

  List<Category> _list = [];
  List<Book> _books = [];
  List<Book> _popularBooks = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
loadCategories();
    });
  }

  void loadCategories(){
    ajax(url: "MobileHomepage",method: "POST",onValue: (s,v){
      setState(() {
        _list = (s['HomeCategories'] as Iterable).map((e) => Category.fromJson(e)).toList();
        _books = (s['RecentlyAddedBooks'] as Iterable).map((e) => Book.fromJson(e)).toList();
        _popularBooks = (s['PopularBooks'] as Iterable).map((e) => Book.fromJson(e)).toList();
      });
    },error: (s,v){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 10,
        title: Row(
          children: [
             Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                child: Text((User.user?.fName??"XA").toUpperCase().substring(0,1)),
                radius: 14,
              ),
            ),
            Text(
              "Hi, ${User.user?.fName??""}",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.headline6?.color),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: ListView.builder(
        itemCount: _popularBooks.length+1,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          index = index - 1;
          if (index < 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: const EdgeInsets.only(bottom: 15,top: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Categories",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ),
                      TextButton(onPressed: (){
                        push(Scaffold(appBar: AppBar(
                          iconTheme: IconThemeData(
                            color: Theme.of(context).textTheme.headline6?.color
                          ),
                          elevation: 3,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          titleTextStyle: Theme.of(context).textTheme.headline6,
                          title: const Text("Categories"),
                        ),body: CategoryScreen(list: _list)));
                      }, child: const Text("More")),
                    ],
                  ),
                ),
                CategoryScreen(list: _list,scrollable: false,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Recent Books",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        var book = _books[index];
                        return SizedBox(
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: (){
                                push( BookDetailScreen(book: book,));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image(
                                            image: CachedNetworkImageProvider(book.image),
                                            fit: BoxFit.cover,
                                          ))),
                                  const SizedBox(height: 10),
                                  Text(
                                    book.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    book.category??"",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.color),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            );
          }


          var item = _popularBooks[index];

          return BookItemWidgetScreen(book: item);
        },
      ),
    );
  }
}
