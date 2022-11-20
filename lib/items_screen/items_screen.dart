import 'package:ecommerce_clone/items_screen/item_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'items_model.dart';

class ItemsScreen extends StatelessWidget {
  ItemsScreen({Key? key, required this.categoryId, required this.categoryTitle})
      : super(key: key);
  final String categoryId, categoryTitle;
  final controller = Get.put(ItemScreenController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    controller.categoryTitle = categoryTitle;
    controller.categoryId = categoryId;
    controller.getPaginatedData;
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryTitle),
            backgroundColor: Colors.blueAccent,
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(children: [
              SizedBox(
                width: size.width / 40,
              ),
              Expanded(
                child: SizedBox(
                  child: GetBuilder<ItemScreenController>(builder: (value) {
                    if (!value.isLoading) {
                      return ListView.builder(
                          controller: controller.scrollController,
                          itemCount: value.itemsData.length,
                          itemBuilder: (context, index) {
                            return listViewBuilderItems(
                                size, value.itemsData[index]);
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                ),
              ),
              Obx(() {
                if (controller.isLoading1.value) {
                  return Container(
                    height: size.height / 10,
                    width: size.width,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              })
            ]),
          ),
        ),
      ),
    );
  }

  Widget listViewBuilderItems(Size size, ItemsModel model) {
    int discount =
        controller.calculateDiscount(model.totalPrice, model.sellingPrice);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: size.height / 8,
          width: size.width / 1.1,
          child: Row(children: [
            Container(
              height: size.height / 8,
              width: size.width / 4.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.image),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 22,
            ),
            Expanded(
              child: SizedBox(
                child: RichText(
                  text: TextSpan(
                      text: "${model.title}\n",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "${model.totalPrice}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        TextSpan(
                          text: "${model.sellingPrice}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "$discount% off",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget searchBar(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        child: Container(
          height: size.height / 14,
          width: size.width / 1.1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Search Here...',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.search, size: 30),
              ]),
        ),
      ),
    );
  }
}
