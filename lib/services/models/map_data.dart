import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MapData mapDataFromJson(String str) => MapData.fromJson(json.decode(str));

String mapDataToJson(MapData data) => json.encode(data.toJson());

class MapData {
  final int index;
  final String uid;
  final String sectionId;
  final String productId;
  final String productName;
  final int stockpile;
  final DateTime createdAt;
  final String? id;

  const MapData({
    required this.index,
    required this.uid,
    required this.sectionId,
    required this.productId,
    required this.productName,
    required this.createdAt,
    required this.stockpile,
    this.id,
  });

  factory MapData.fromJson(QueryDocumentSnapshot<Object?> json) => MapData(
        index: json["index"],
        stockpile: json["stockpile"],
        uid: json["uid"],
        sectionId: json["sectionId"],
        productId: json["productId"],
        productName: json["productName"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json.id,
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "uid": uid,
        "sectionId": sectionId,
        "productId": productId,
        "productName": productName,
        "createdAt": createdAt.toIso8601String(),
        "stockpile": stockpile,
      };
}
