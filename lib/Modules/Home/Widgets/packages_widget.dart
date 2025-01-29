import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/packages_model.dart';
import '../../../Models/slider_model.dart';

class PackagesWidget extends StatelessWidget{
 final SliderModel sliderModel;
  const PackagesWidget({super.key, required this.sliderModel});
 @override
 Widget build(BuildContext context) {
   return Container(
     width: 328.w,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(30.r),
     ),
     child: ClipRRect(
       borderRadius: BorderRadius.circular(30.r),
       child: Image.network(
         sliderModel.image ?? '', // Network image URL
         fit: BoxFit.cover,
         width: 328.w,
         height: 192.h, // Adjust height as needed
         errorBuilder: (context, error, stackTrace) {
           // Fallback widget when the image fails to load
           return Container(
             color: Colors.grey[300], // Background color for the fallback
             alignment: Alignment.center,
             child: const Icon(
               Icons.image, // Built-in icon as a fallback
               size: 50,
               color: Colors.grey,
             ),
           );
         },
       ),
     ),
   );
 }
 //  @override
 //  Widget build(BuildContext context) {
 //   return  Container(
 // width:328.w,
 //     decoration:  BoxDecoration(
 //       //  color: Colors.red,
 //       borderRadius: BorderRadius.circular(30.r),
 //         image: DecorationImage(
 //           fit: BoxFit.cover,
 //             image:NetworkImage(sliderModel.image??"",
 //             )
 //         )
 //     ),
 //   );
 //  }
}