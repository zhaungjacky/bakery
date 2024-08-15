import 'package:cloud_firestore/cloud_firestore.dart';

class TagModel {
  final String category;
  final int numbersOfProduct;
  final int barCodeNumber;
  final String packageType;
  final String producedDay;
  final int duration;
  final String info;
  final bool isLegal;
  final String? id;
  final String? expiredDate;
  final bool? isCategory;

  TagModel({
    required this.category,
    required this.numbersOfProduct,
    required this.barCodeNumber,
    required this.packageType,
    required this.producedDay,
    required this.duration,
    required this.info,
    required this.isLegal,
    this.id,
    this.expiredDate,
    this.isCategory = false,
  });

  factory TagModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return TagModel(
      category: json['category'],
      numbersOfProduct: json['numbersOfProduct'],
      barCodeNumber: json['barCodeNumber'],
      packageType: json['packageType'],
      producedDay: json['producedDay'],
      duration: json['duration'],
      info: json['info'],
      isLegal: json['isLegal'],
      id: json.id,
      expiredDate: json['expiredDate'],
      isCategory: false,
    );
  }

  factory TagModel.foundCategory(TagModel json) {
    return TagModel(
      category: json.category,
      numbersOfProduct: json.numbersOfProduct,
      barCodeNumber: json.barCodeNumber,
      packageType: json.packageType,
      producedDay: json.producedDay,
      duration: json.duration,
      info: json.info,
      isLegal: json.isLegal,
      id: json.id,
      expiredDate: json.expiredDate,
      isCategory: true,
    );
  }
  factory TagModel.makeTagInactivate(TagModel json) {
    return TagModel(
      category: json.category,
      numbersOfProduct: json.numbersOfProduct,
      barCodeNumber: json.barCodeNumber,
      packageType: json.packageType,
      producedDay: json.producedDay,
      duration: json.duration,
      info: json.info,
      isLegal: false,
      id: json.id,
      expiredDate: json.expiredDate,
      isCategory: json.isCategory,
    );
  }

  factory TagModel.fromMapData(Map<String, dynamic> json) {
    return TagModel(
      category: json['category'],
      numbersOfProduct: json['numbersOfProduct'],
      barCodeNumber: json['barCodeNumber'],
      packageType: json['packageType'],
      producedDay: json['producedDay'],
      duration: json['duration'],
      info: json['info'],
      isLegal: json['isLegal'],
      expiredDate: json['expiredDate'],
      id: json['id'],
      isCategory: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'numbersOfProduct': numbersOfProduct,
      'barCodeNumber': barCodeNumber,
      'packageType': packageType,
      'producedDay': producedDay,
      'duration': duration,
      'info': info,
      'isLegal': isLegal,
      'expiredDate': (DateTime.parse(producedDay))
          .add(Duration(days: duration))
          .toIso8601String(),
    };
  }
}
