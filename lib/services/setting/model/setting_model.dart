import 'package:cloud_firestore/cloud_firestore.dart';

class SettingModel {
  final double fontSize;
  final List<double> heightsPercentList;
  final List<double> widthPercentList;
  final List<double> tagWidthPercentList;
  final int durationShort;
  final int durationMedium;
  final int durationLong;
  final int durationExtraLong;
  final bool showDrawerAddSettingZone;
  final String? id;

  SettingModel({
    required this.fontSize,
    required this.heightsPercentList,
    required this.widthPercentList,
    required this.tagWidthPercentList,
    required this.durationShort,
    required this.durationMedium,
    required this.durationLong,
    required this.durationExtraLong,
    required this.showDrawerAddSettingZone,
    this.id,
  });

  factory SettingModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    final widthPercentList =
        List<double>.from(json['widthPercentList'] as List);
    // print(widthPercentList);
    final heightsPercentList =
        List<double>.from(json['heightsPercentList'] as List);
    // print(heightsPercentList);
    final tagWidthPercentList =
        List<double>.from(json['tagWidthPercentList'] as List);
    // print(heightsPercentList);

    return SettingModel(
      fontSize: json['fontSize'],
      heightsPercentList: heightsPercentList,
      widthPercentList: widthPercentList,
      tagWidthPercentList: tagWidthPercentList,
      durationShort: json['durationShort'],
      durationMedium: json['durationMedium'],
      durationLong: json['durationLong'],
      durationExtraLong: json['durationExtraLong'],
      showDrawerAddSettingZone: json['showDrawerAddSettingZone'],
      id: json.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'heightsPercentList': heightsPercentList,
      'widthPercentList': widthPercentList,
      'tagWidthPercentList': tagWidthPercentList,
      'durationShort': durationShort,
      'durationMedium': durationMedium,
      'durationLong': durationLong,
      'durationExtraLong': durationExtraLong,
      'showDrawerAddSettingZone': showDrawerAddSettingZone,
    };
  }
}
