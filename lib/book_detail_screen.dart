import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/json/book.dart';
import 'package:library_app/super_base.dart';

class BookDetailScreen extends StatefulWidget{
  final Book book;
  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends Superbase<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var exist = bookExists(widget.book);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:
        IconThemeData(color: Theme.of(context).textTheme.headline6?.color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: (){

            String msg ="Book added to bookmark";
            if( exist ) {
              msg ="Book removed from bookmark";
              removeFromBookMark(widget.book);
            } else {
              addToBookMark(widget.book);
            }
            setState(() {
              // widget.parentReload?.call();
              showSnack(msg);
            });
          },icon: Icon( exist ? Icons.bookmark : Icons.bookmark_add_outlined,color: exist ? Colors.amber : null,))
          // PopupMenuButton(itemBuilder: (context)=>[]),
        ],
      ),
      body: ListView(
        children: [
          Center(child: Image(image: CachedNetworkImageProvider(widget.book.image),frameBuilder: frameBuilder,fit: BoxFit.cover,height: 300,)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(widget.book.name,textAlign: TextAlign.center,style: const TextStyle(
                    fontSize: 25
                  ),),
                  Text("Suzy Menkes",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.headline4?.color
                  ),),
                  Text("Language : ${widget.book.lang??""}",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.headline6?.color
                  ),),
                  const SizedBox(height: 5,),
                  Text(widget.book.category??"",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 14,
                    color: Theme.of(context).textTheme.headline4?.color
                  ),),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 12),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [1, 2, 3, 4, 5,6]
                  //         .map((e) => e>5 ? const Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 8),
                  //           child: Text("4/5"),
                  //         ) :  Icon(
                  //       Icons.star,
                  //       size: 20,
                  //       color: e < 4
                  //           ? Colors.amber
                  //           : const Color(0xffEDEDEF),
                  //     ))
                  //         .toList(),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("A spectacular visual journey through 40 years of haute couture from one of the best-known and most trend-setting brands in fashion.",style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).textTheme.headline4?.color
                    ),textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0.6),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              backgroundColor: MaterialStateProperty.all(const Color(0xff02A95C))
            ),
            onPressed: (){},
            child: const Text("Borrow Now"),
          ),
        ),
      ),
    );
  }
}