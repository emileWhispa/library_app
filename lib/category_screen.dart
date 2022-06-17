import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/category_book_screen.dart';
import 'package:library_app/json/category.dart';
import 'package:library_app/super_base.dart';

class CategoryScreen extends StatefulWidget{
  final List<Category> list;
  final bool scrollable;

  const CategoryScreen({Key? key, required this.list, this.scrollable = true}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends Superbase<CategoryScreen> {

  List<Category>? _list;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.scrollable){
        loadData();
      }
    });
    super.initState();
  }

  List<Category> get list => _list ?? widget.list;

  Future<void> loadData(){
    return ajax(url: "AllCategories",method: "POST",onValue: (s,v){
      setState(() {
        _list = (s['AllCategory'] as Iterable?)?.map((e) => Category.fromJson(e)).toList() ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: widget.scrollable ? false : true,
      itemCount: list.length,
      physics: widget.scrollable ? null : const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
      itemBuilder: (context,index){
        var e = list[index];
        return Container(
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
              onTap: (){
                push(CategoryBookScreen(category: e));
              },
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
        );
      },
    );
  }
}