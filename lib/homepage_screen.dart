import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library_app/book_detail_screen.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/json/user.dart';
import 'package:library_app/super_base.dart';

import 'json/category.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

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
    ajax(url: "MobileHomepage",method: "POST",data: FormData.fromMap({
      "role":"Adults"
    }),onValue: (s,v){
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 15,top: 5),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: _list
                      .map((e) => Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffE5E5E5),
                              offset: Offset(0.5,0.7),
                              blurRadius: 9
                            )
                          ]
                        ),
                        child: Material(
                          color: Theme.of(context).cardColor,
                          child: InkWell(
                            onTap: (){},
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Expanded(child: Image(image: CachedNetworkImageProvider(e.image),frameBuilder: frameBuilder,)),
                                  Text(e.name,textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(
                                    fontSize: 13
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                      .toList(),
                ),
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

          return InkWell(
            onTap: (){
              push(BookDetailScreen(book: item));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image(
                      image: CachedNetworkImageProvider(item.image),
                      frameBuilder: frameBuilder,
                      height: 83,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          item.category??"",
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline4?.color),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 12),
                        //   child: Row(
                        //     children: [1, 2, 3, 4, 5]
                        //         .map((e) => Icon(
                        //               Icons.star,
                        //               size: 15,
                        //               color: e < 4
                        //                   ? Colors.amber
                        //                   : const Color(0xffEDEDEF),
                        //             ))
                        //         .toList(),
                        //   ),
                        // )
                      ],
                    ),
                  )),
                  const Icon(Icons.bookmark_add_outlined)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
