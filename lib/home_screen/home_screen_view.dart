import 'package:ecommerce_clone/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'drawer.dart';
import 'model_class/categories_model.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(HomeScreenController());
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(child: GetBuilder<HomeScreenController>(
        builder: (value) {
          if (value.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Ecommerce App"),
                backgroundColor: Colors.blueAccent,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              drawer: HomeScreenDrawer(),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 3.5,
                        width: size.width,
                        child: PageView.builder(
                            onPageChanged: (index) =>
                                controller.changeIndicator(index),
                            itemCount: controller.bannerData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          controller.bannerData[index].image),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: size.height / 25,
                        width: size.width,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < controller.isSelected.length;
                                  i++)
                                indicator(size, controller.isSelected[i].value)
                            ],
                          );
                        }),
                      ),
                      categoriesTitle(size, "All Categories", () {}),
                      listViewBuilder(size, controller.categoriesData),
                      SizedBox(
                        height: size.height / 25,
                      ),
                      categoriesTitle(size, "Featured", () {}),
                      listViewBuilder(size, controller.featuredData),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      )),
    );
  }
}

Widget indicator(Size size, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      height: isSelected ? size.height / 80 : size.height / 100,
      width: isSelected ? size.height / 80 : size.height / 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    ),
  );
}

Widget listViewBuilder(Size size, List<CategoriesModel> data) {
  return SizedBox(
    height: size.height / 7,
    width: size.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return listViewBuilderItems(size, data[index]);
        }),
  );
}

Widget listViewBuilderItems(Size size, CategoriesModel categories) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: size.height / 7,
        width: size.width / 4.2,
        child: Column(children: [
          Container(
            height: size.height / 10,
            width: size.width / 2.2,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(categories.image),
            )),
          ),
          Expanded(
              child: SizedBox(
            child: Text(
              categories.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ))
        ]),
      ),
    ),
  );
}

Widget categoriesTitle(Size size, String title, Function function) {
  return SizedBox(
    height: size.height / 17,
    width: size.width / 1.05,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () => function(),
          child: const Text("View More",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
              )),
        ),
      ],
    ),
  );
}
