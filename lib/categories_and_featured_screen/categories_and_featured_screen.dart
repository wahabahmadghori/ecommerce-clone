import 'package:ecommerce_clone/home_screen/model_class/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesAndFeaturedScreen extends StatelessWidget {
  CategoriesAndFeaturedScreen({Key? key, required this.model})
      : super(key: key);
  List<CategoriesModel> model;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("All Categories"),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return gridViewBuilderItems(Get.size, model[index]);
                }),
          ),
        ),
      ),
    );
  }
}

Widget gridViewBuilderItems(Size size, CategoriesModel categories) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: size.height / 7,
        width: size.width / 4.2,
        child: Column(children: [
          Container(
            height: size.height / 8,
            width: size.width / 2.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(categories.image),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                categories.title,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          )
        ]),
      ),
    ),
  );
}
