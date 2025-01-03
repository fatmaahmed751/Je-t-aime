import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../../../../Utilities/strings.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Widgets/custom_textfield_widget.dart';
import '../../../../generated/assets.dart';
import '../../../Utilities/validate.dart';


class SearchWidget extends StatefulWidget {
  final bool isSearch;
  final Function(String?) onSearch;
  final Function(String?) onChange;
  final Function() onRemove;
  final Color backGroundColor;
  final double width;
  final TextEditingController controller;
   const SearchWidget({super.key,required this.onSearch, required this.isSearch, required this.controller, required this.onRemove, required this.onChange, required this.backGroundColor, required this.width});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return  CustomTextFieldWidget(
      onSave:widget.onSearch,
     controller:widget.controller,
      width: widget.width,
      height: 45.h,
      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
      borderRadiusValue: 30.r,
      isDense: true,
      prefixIcon: SvgPicture.asset(Assets.imagesSearch),
      hint: Strings.searchHere.tr,
      backGroundColor:widget.backGroundColor,
     // ThemeClass.of(context).secondary.withOpacity(1),
      onchange:widget.onChange,
      hintStyle: TextStyle(
          color: ThemeClass.of(context)
              .secondaryBlackColor
              .withOpacity(0.7)),
      validator: (v) => Validate.validateNormalString(v),
      // suffixIcon:
      // widget.isSearch||widget.controller.text.trim().isNotEmpty?
      // InkWell(
      //   onTap:widget.onRemove,
      //   child: Padding(
      //     padding:EdgeInsetsDirectional.only(start:4.w,end:4.w),
      //     child: Row(
      //       // mainAxisAlignment:
      //       // MainAxisAlignment.spaceAround,
      //       children: [
      //         IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp,
      //         color: ThemeClass.of(context).secondary,))
      //       ],
      //     ),
      //   ),
      // ):const SizedBox(),

    );
  }
}
