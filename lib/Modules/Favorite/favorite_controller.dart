import 'package:flutter/cupertino.dart';
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/popular_products_model.dart";
import "favorite_data_handler.dart";

class FavoriteController extends ControllerMVC {
  // singleton
  factory FavoriteController() {
    _this ??= FavoriteController._();
    return _this!;
  }

  static FavoriteController? _this;
  bool isUserHaveFavorites = false;
  FavoriteController._();
  bool loading = false;
  bool isLiked = false;
  bool isLogin = false;
  late TextEditingController searchController;
  List<PopularProductsModel> products=[];
  static const pageSize = 10;
  PagingController<int, PopularProductsModel> get pagingController => _pagingController;

  final PagingController<int, PopularProductsModel> _pagingController =
  PagingController(firstPageKey: 0);
  @override
  void initState() {
    searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      getFavorites(pageKey);
    });
    super.initState();
  }
  init() {
    if (_pagingController.itemList == null ||
        _pagingController.itemList!.isEmpty) {
      getFavorites(_pagingController.firstPageKey);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  Future<void> getFavorites(int pageKey) async {
    //try {
    final newItems = await FavoritesDataHandler.favoritesProduct(
      pageKey,
      pageSize,
    );
    newItems.fold(
            (failure) {
          _pagingController.error = failure;
        },
            (products) {
          final isLastPage = products.length < pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(products);
          } else {
            final nextPageKey = pageKey + products.length;
            _pagingController.appendPage(products, nextPageKey);
          }
        }
    );

  }
}
