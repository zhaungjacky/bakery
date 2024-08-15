import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MapData mapDataFromJson(String str) => MapData.fromJson(json.decode(str));

String mapDataToJson(MapData data) => json.encode(data.toJson());

ZoneList zoneListFromJson(String str) => ZoneList.fromJson(json.decode(str));
String zoneListToJson(ZoneList data) => json.encode(data.toJson());

class MapData {
  final String id;
  final String sectionId;
  final int index;
  final String productId;
  final String productName;
  final int stockpile;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MapData({
    required this.id,
    required this.sectionId,
    required this.index,
    required this.productId,
    required this.productName,
    required this.stockpile,
    this.createdAt,
    this.updatedAt,
  });

  factory MapData.fromMap(Map<String, dynamic> json) => MapData(
        id: json["id"],
        stockpile: json["stockpile"],
        index: json["index"],
        sectionId: json["sectionId"],
        productId: json["productId"],
        productName: json["productName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory MapData.fromJson(QueryDocumentSnapshot<Object?> json) => MapData(
        id: json["id"],
        stockpile: json["stockpile"],
        index: json["index"],
        sectionId: json["sectionId"],
        productId: json["productId"],
        productName: json["productName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "index": index,
        "productId": productId,
        "productName": productName,
        "stockpile": stockpile,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class ZoneList {
  final String sectionId;
  final int index;
  final List<MapData>? list;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isCategory;

  ZoneList({
    required this.sectionId,
    required this.index,
    this.list,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isCategory = false,
  });

  factory ZoneList.fromJson(QueryDocumentSnapshot<Object?> json) => ZoneList(
        sectionId: json["sectionId"],
        index: json["index"],
        list: List.from(json["list"])
            .map(
              (val) => MapData.fromMap(val),
            )
            .toList(),
        id: json.id,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isCategory: false,
      );
  factory ZoneList.isThatCategory(ZoneList zone) => ZoneList(
        sectionId: zone.sectionId,
        index: zone.index,
        list: zone.list,
        id: zone.id,
        createdAt: zone.createdAt,
        updatedAt: zone.updatedAt,
        isCategory: true,
      );

  Map<String, dynamic> toJson() => {
        'sectionId': sectionId,
        'index': index,
        'list': list?.map((val) => val.toJson()),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
