import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/packages_model.dart';

class PackagesWidget extends StatelessWidget{
 final PackagesModel packagesModel;
  const PackagesWidget({super.key, required this.packagesModel});

  @override
  Widget build(BuildContext context) {
   return  Container(

   height:192.h,
   width:328.w,
     decoration:  BoxDecoration(
         color: Colors.red,
       borderRadius: BorderRadius.circular(30.r),
         image: DecorationImage(
           fit: BoxFit.cover,
             image:AssetImage(packagesModel.imageName,
             )
         )
     ),
   );

  }}