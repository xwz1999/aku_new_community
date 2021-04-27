class BaseListModel {
  int? pageCount;
  int? rowCount;
  List<dynamic>? tableList;
  BaseListModel({
    this.pageCount,
    this.rowCount,
    this.tableList,
  });
  BaseListModel.zero({
    this.pageCount = 0,
    this.rowCount = 0,
    this.tableList = const [],
  });

  BaseListModel.err({
    this.pageCount = 0,
    this.rowCount = 0,
    this.tableList = const [],
  });

  BaseListModel.fromJson(Map<String, dynamic> json) {
    pageCount = json['pageCount'] ?? 0;
    rowCount = json['rowCount'] ?? 0;
    tableList = json['tableList'] ?? [];
  }
}
