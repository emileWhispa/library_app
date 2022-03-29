import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget{
  const BookDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:
        IconThemeData(color: Theme.of(context).textTheme.headline6?.color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark_border)),
          PopupMenuButton(itemBuilder: (context)=>[]),
        ],
      ),
      body: ListView(
        children: [
          Center(child: Image.asset("assets/book_pink.png",fit: BoxFit.cover,height: 300,)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text("Yves Saint Laurent",textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 26
                  ),),
                  Text("Suzy Menkes",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 14,
                    color: Theme.of(context).textTheme.headline4?.color
                  ),),

                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1, 2, 3, 4, 5,6]
                          .map((e) => e>5 ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("4/5"),
                          ) :  Icon(
                        Icons.star,
                        size: 20,
                        color: e < 4
                            ? Colors.amber
                            : const Color(0xffEDEDEF),
                      ))
                          .toList(),
                    ),
                  ),
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
            child: Text("Borrow Now for  5,000 RWF"),
          ),
        ),
      ),
    );
  }
}