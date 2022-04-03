import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/super_base.dart';

import 'book_detail_screen.dart';

class BookItemWidgetScreen extends StatefulWidget{
  final Book book;
  final VoidCallback? parentReload;
  const BookItemWidgetScreen({Key? key, required this.book, this.parentReload}) : super(key: key);

  @override
  State<BookItemWidgetScreen> createState() => _BookItemWidgetScreenState();
}

class _BookItemWidgetScreenState extends Superbase<BookItemWidgetScreen> {

  Book get item =>widget.book;

  @override
  Widget build(BuildContext context) {
    var exist = bookExists(item);
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
            IconButton(onPressed: (){

              String msg ="Book added to bookmark";
              if( exist ) {
                msg ="Book removed from bookmark";
                removeFromBookMark(item);
              } else {
                addToBookMark(item);
              }
              setState(() {
                widget.parentReload?.call();
                showSnack(msg);
              });
            },icon: Icon( exist ? Icons.bookmark : Icons.bookmark_add_outlined,color: exist ? Colors.amber : null,))
          ],
        ),
      ),
    );
  }
}