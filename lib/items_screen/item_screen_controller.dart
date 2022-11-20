import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_clone/items_screen/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();
  String categoryId = "";
  String categoryTitle = "";
  List<ItemsModel> itemsData = [];
  List<ItemsModel> searchResults = [];
  bool isLoading = true;
  bool isSearchLoading = false;
  bool hasModeData = true;
  var isLoading1 = false.obs;
  DocumentSnapshot? lastDocument;
  int documentLimit = 7;

  Future<void> getSubCategoryData() async {
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .get()
          .then((value) {
        itemsData =
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
      });
      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  void getPaginatedData() async {
    if (hasModeData) {
      if (!isLoading1.value) {
        await getSubCategoryData();
      }
    } else {
      print("No More Data");
    }
  }

  Future<void> getSubCategoryDataInParts() async {
    if (lastDocument == null) {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData.addAll(
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList());
        isLoading = false;
        update();
        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasModeData = false;
        }
      });
    } else {
      isLoading1.value = true;
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData.addAll(
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList());
        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasModeData = false;
        }
      });
    }
  }

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice);
    return discount.toInt();
  }

  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      isSearchLoading = true;
      Future.delayed(Duration.zero, () {
        update();
      });

      try {
        await _firestore
            .collection('categories')
            .doc(categoryId)
            .collection(categoryTitle)
            .where('title', isGreaterThanOrEqualTo: query)
            .get()
            .then((value) {
          searchResults =
              value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
          isSearchLoading = false;
          update();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      double maxScrollExten = scrollController.position.maxScrollExtent;
      double currentPosition = scrollController.position.pixels;
      double height20 = Get.size.height * 0.20;
      if (maxScrollExten - currentPosition <= height20) {
        getPaginatedData();
      }
    });
  }
}
