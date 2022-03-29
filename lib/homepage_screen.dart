import 'package:flutter/material.dart';
import 'package:library_app/book_detail_screen.dart';
import 'package:library_app/super_base.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends Superbase<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/hubert.png"),
                radius: 14,
              ),
            ),
            Text(
              "Hi, Hubert",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.headline6?.color),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: ListView.builder(
        itemCount: 5000,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          if (index == 0) {
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
                  children: [1, 2, 3, 4, 5, 6]
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
                                  Expanded(child: Image.asset("assets/open_book.png")),
                                  const Text("Category Name",textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
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
                    "Popular Books",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5000,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            push(const BookDetailScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/book_image.png",
                                          fit: BoxFit.cover,
                                        ))),
                                const SizedBox(height: 10),
                                Text(
                                  "Fashionopolis",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "Patrick Mauriès",
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
                        );
                      }),
                )
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    "assets/book_pink.png",
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
                        "Yves Saint Laurent",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "Suzy Menkes",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color:
                                Theme.of(context).textTheme.headline4?.color),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: [1, 2, 3, 4, 5]
                              .map((e) => Icon(
                                    Icons.star,
                                    size: 15,
                                    color: e < 4
                                        ? Colors.amber
                                        : const Color(0xffEDEDEF),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                )),
                const Icon(Icons.bookmark_add_outlined)
              ],
            ),
          );
        },
      ),
    );
  }
}
