import 'package:edu_apply/core/common/entities/sort_data.dart';

class Pageable {
  int pageNumber;
  int pageSize;
  SortData sort;
  int offset;
  bool paged;
  bool unpaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });
}
