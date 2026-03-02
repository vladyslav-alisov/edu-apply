import 'package:edu_apply/core/common/entities/sort_data.dart';

class SortDataModel extends SortData {
  SortDataModel({
    required super.sorted,
    required super.empty,
    required super.unsorted,
  });

  factory SortDataModel.fromJson(Map<String, dynamic> json) => SortDataModel(
        sorted: json["sorted"],
        empty: json["empty"],
        unsorted: json["unsorted"],
      );
}
