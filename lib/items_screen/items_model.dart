class ItemsModel {
  late String id;
  late String image;
  late String title;
  late String detailId;
  late int totalPrice;
  late int sellingPrice;
  ItemsModel({
    required this.id,
    required this.image,
    required this.title,
    required this.detailId,
    required this.totalPrice,
    required this.sellingPrice,
  });
  ItemsModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    image = map['img'];
    detailId = map['details_id'] ?? "";
    title = map['title'];
    sellingPrice = map['sell_price'];
    totalPrice = map['total_price'];
  }
}
