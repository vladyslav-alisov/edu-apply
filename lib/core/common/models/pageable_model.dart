import 'package:edu_apply/core/common/entities/pageable.dart';
import 'package:edu_apply/core/common/models/sort_data_model.dart';

class PageableModel extends Pageable {
  PageableModel({
    required super.pageNumber,
    required super.pageSize,
    required super.sort,
    required super.offset,
    required super.paged,
    required super.unpaged,
  });

  factory PageableModel.fromJson(Map<String, dynamic> json) => PageableModel(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        sort: SortDataModel.fromJson(json["sort"]),
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );
}
