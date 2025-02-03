
class GenericPaginationModel<T>{
  final int totalItemsCount;
  final int currentPageSize;
  final int currentPageIndex;
  List<T> data;

  bool get hasNextPge => data.length<totalItemsCount;
  Map<String,dynamic> get nextData => {
    "pageSize": currentPageSize,
    "pageIndex": currentPageIndex+1,
  };
  Map<String,dynamic> get nextDataQuery => {
    "pageSize": currentPageSize.toString(),
    "pageIndex": (currentPageIndex+1).toString(),
  };
  GenericPaginationModel({this.totalItemsCount = 0, this.currentPageIndex = 0,this.currentPageSize = 10,this.data = const []});


  factory GenericPaginationModel.fromJson(Map<String, dynamic> json,{required T Function(Map<String,dynamic>) fromJson}){
    return GenericPaginationModel(
      totalItemsCount: json["total_count"]??0,
      currentPageSize: json["pageSize"]??10,
      currentPageIndex: json["pageIndex"]??1,
      data: json["data"] == null? []: List<T>.from((json["data"] as List).map((e) => fromJson(e))),
    );
  }
}