import 'package:edu_apply/core/common/entities/paginated_response.dart';
import 'package:edu_apply/core/common/models/pageable_model.dart';
import 'package:edu_apply/core/common/models/sort_data_model.dart';

class PaginatedResponseModel<T> extends PaginatedResponse<T> {
  PaginatedResponseModel({
    required super.content,
    required super.pageable,
    required super.totalPages,
    required super.totalElements,
    required super.last,
    required super.size,
    required super.number,
    required super.sort,
    required super.numberOfElements,
    required super.first,
    required super.empty,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) =>
      PaginatedResponseModel(
        content: List<T>.from(json['content'].map((item) => fromJsonT(item))),
        pageable: PageableModel.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        size: json["size"],
        number: json["number"],
        sort: SortDataModel.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
      );
}
