// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import '../../../../Utilities/theme_helper.dart';
// import '../../../Widgets/custom_network_image.dart';
// class ProductCarouselWidget extends StatefulWidget {
//   final int activeIndex;
//   final Function(int index) onPageChange;
//   final List imageUrl;
//   const ProductCarouselWidget({super.key, required this.activeIndex, required this.onPageChange, required this.imageUrl});
//
//   @override
//   State<ProductCarouselWidget> createState() => _ProductCarouselWidgetState();
// }
//
// class _ProductCarouselWidgetState extends State<ProductCarouselWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: widget.imageUrl.length,
//           itemBuilder: (BuildContext context, int index, int realIndex) {
//             final urlImage=widget.imageUrl[index];
//             return CustomNetworkImage(
//               height: 201.h,
//               width: 382.w,
//               url:urlImage ,
//               radius: 20.r,
//             ) ;
//           },
//           options: CarouselOptions(
//               autoPlay: true,
//               aspectRatio: 16/9,
//               viewportFraction: 1,
//               height: 201.h,
//               onPageChanged:(index,reason)=> widget.onPageChange(index)),
//         ),
//         Padding(
//           padding:  EdgeInsets.only(top:20.h),
//           child: AnimatedSmoothIndicator(
//             effect: ExpandingDotsEffect(dotWidth:8.r,activeDotColor: ThemeClass.of(context).primaryColor,dotHeight: 8.r, ),
//             activeIndex: widget.activeIndex,
//             count: widget.imageUrl.length,
//           ),
//         )
//       ],
//     );
//   }
// }
