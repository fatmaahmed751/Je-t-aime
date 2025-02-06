import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/Reviews/reviews_controller.dart";
import "package:je_t_aime/Modules/Reviews/widget/reviews_widget.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../../Utilities/strings.dart";
import "../../../Utilities/theme_helper.dart";
import "../../../Widgets/loading_screen.dart";
import "../../Models/review_model.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../generated/assets.dart";

class ReviewsForProductScreen extends StatefulWidget {
  static const routeName = "reviewScreen";
  final PopularProductsModel productsModel;
  const ReviewsForProductScreen({
    Key? key, required this.productsModel,
  }) : super(key: key);

  @override
  createState() => _ReviewsForProductScreenState();
}

class _ReviewsForProductScreenState extends StateMVC<ReviewsForProductScreen> {
  _ReviewsForProductScreenState() : super(ReviewsForProductController()) {
    con = ReviewsForProductController();
  }
  late ReviewsForProductController con;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con.init( reviewProductId: widget.productsModel.id??0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.reviews.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
            child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 23.w, vertical: 5.h),
          child:  ListView(

            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "24 ${Strings.rate.tr}",
                    style: TextStyleHelper.of(context).b_16.copyWith(
                        decoration: TextDecoration.underline,
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withOpacity(0.6)),
                  ),
                  GestureDetector(
                    onTap: () {
                      con.postRatedSuccessfully();
                    },
                    child: SvgPicture.asset(Assets.imagesEdit),
                  ),
                ],
              ),
      SizedBox(
        height: 500.h,
        child: PagedListView<int, ReviewModel>(
          pagingController: con.pagingController,
          builderDelegate: PagedChildBuilderDelegate<ReviewModel>(
            itemBuilder: (context, item, index) {
              return ReviewsItem(reviewsModel: item);
            },
            firstPageProgressIndicatorBuilder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
            newPageProgressIndicatorBuilder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
            noItemsFoundIndicatorBuilder: (context) {
              return const Center(child: Text("No reviews found"));
            },
            noMoreItemsIndicatorBuilder: (context) {
              return const Center(child: Text("No more reviews"));
            },
            // errorIndicatorBuilder: (context) {
            //   return Center(child: Text('Error loading reviews'));
            // },
          ),
        ),
      ),
    ]

              // if (con.reviews.isNotEmpty)
              //   ...con.reviews.map((e) {
              //     return ReviewsItem(reviewsModel: e);
              //   }).toList(),

              ),
    ),
        ),
      ),
    );
  }
}
