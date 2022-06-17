import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/super_base.dart';

import 'book_detail_screen.dart';

class BookItemWidgetScreen extends StatefulWidget {
  final Book book;
  final VoidCallback? parentReload;
  final bool hideFavIcon;

  const BookItemWidgetScreen({Key? key, required this.book, this.parentReload, this.hideFavIcon = false})
      : super(key: key);

  @override
  State<BookItemWidgetScreen> createState() => _BookItemWidgetScreenState();
}

class _BookItemWidgetScreenState extends Superbase<BookItemWidgetScreen> {
  Book get item => widget.book;

  Future<void> addRemoteBookmark() async {
    setState(() {
      item.loading = true;
    });
    await addToBookMark(item);
    setState(() {
      item.loading = false;
    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    var exist = bookExists(item);
    return InkWell(
      onTap: () {
        push(BookDetailScreen(book: item));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                Positioned(
                    bottom: 5,
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(3)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      child: Text(
                        (widget.book.lang ?? "Lang")
                            .substring(0, 2)
                            .toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11.2),
                      ),
                    ))
              ],
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      item.category ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: const Color(0xffFED857)),
                    ),
                  ),
                  Text(
                    "Short Description will goe here  Short Description will go..",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: Theme.of(context).textTheme.headline5?.color),
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
            widget.hideFavIcon ? const SizedBox.shrink() : IconButton(
                onPressed: item.loading ? null : ()async {
                  await addRemoteBookmark();
                  setState(() {
                    widget.parentReload?.call();
                  });
                },
                icon: item.loading ? const CupertinoActivityIndicator() : Icon(
                  exist ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: exist ? Colors.amber : null,
                ))
          ],
        ),
      ),
    );
  }
}
