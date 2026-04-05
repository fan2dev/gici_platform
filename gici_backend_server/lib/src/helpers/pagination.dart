class PageRequest {
  const PageRequest({
    required this.page,
    required this.pageSize,
  });

  final int page;
  final int pageSize;

  int get safePage => page < 0 ? 0 : page;
  int get safePageSize {
    if (pageSize < 1) return 20;
    if (pageSize > 100) return 100;
    return pageSize;
  }

  int get offset => safePage * safePageSize;
}

class PageResult<T> {
  const PageResult({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  });

  final List<T> items;
  final int page;
  final int pageSize;
  final int total;
}
