import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../../../../Utilities/strings.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Widgets/custom_textfield_widget.dart';
import '../../../../generated/assets.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/validate.dart';


class SearchWidget extends StatefulWidget {
  final bool isSearch;
  final Function(String?) onSearch;
  final Function(String?) onChange;
  final Function() onRemove;
  final TextEditingController controller;
   SearchWidget({super.key,required this.onSearch, required this.isSearch, required this.controller, required this.onRemove, required this.onChange});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return  CustomTextFieldWidget(
      onSave:widget.onSearch,
     controller:widget.controller,
      height: 45.h,
      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
      borderRadiusValue: 30.r,
      isDense: true,
      prefixIcon: SvgPicture.asset(Assets.imagesSearch),
      hint: Strings.searchHere.tr,
      backGroundColor: ThemeClass.of(context).background,
      onchange:widget.onChange,
      hintStyle: TextStyleHelper.of(context)
          .b_16
          .copyWith(color: ThemeClass.of(context).secondaryBlackColor),
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
