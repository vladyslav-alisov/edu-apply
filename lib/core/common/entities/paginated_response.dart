import 'package:edu_apply/core/common/entities/pageable.dart';
import 'package:edu_apply/core/common/entities/sort_data.dart';

class PaginatedResponse<T> {
  List<T> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  SortData sort;
  int numberOfElements;
  bool first;
  bool empty;

  PaginatedResponse({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });
}
