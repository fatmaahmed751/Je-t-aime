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
 final FocusNode? focusNode;
  final Function() onRemove;
  final Color? backGroundColor, focusedBorderColor;
  final double width;
  final TextEditingController controller;
   const SearchWidget({super.key,required this.onSearch, required this.isSearch, required this.controller, required this.onRemove, required this.onChange, required this.backGroundColor, required this.width, this.focusNode, this.focusedBorderColor});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late FocusNode _focusNode;
  bool _isFocused = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }
  // InputBorder? getBorder({double? radius, Color? color}) {
  //   if (widget.disableBorder) return null;
  //   return OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(28.r),
  //     borderSide: BorderSide(color: color ?? ThemeClass.of(context).secondary,width: 1.w),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return
      CustomTextFieldWidget(
      onSave:widget.onSearch,
     controller:widget.controller,
focusNode:  _focusNode,
        // fillColor :_isFocused
        //     ? Colors.transparent
        //     : widget.backGroundColor ?? Theme.of(context).dividerColor,
        // focusedBorder:
        // filled: true,
focusedBorderColor: Colors.white,
      width: widget.width,
      height: 45.h,
      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
      borderRadiusValue: 30.r,
      isDense: true,
      prefixIcon: SvgPicture.asset(Assets.imagesSearch,
        colorFilter:_isFocused?  ColorFilter.mode(ThemeClass.of(context).pinkColor.withOpacity(0.8), BlendMode.srcIn):null,),
      hint: Strings.searchHere.tr,
      backGroundColor:widget.backGroundColor,
     // ThemeClass.of(context).secondary.withOpacity(1),
      onchange:widget.onChange,
      hintStyle:_isFocused?TextStyle(
          color: ThemeClass.of(context)
              .pinkColor
              .withOpacity(0.7)):  TextStyle(
          color: ThemeClass.of(context)
          .secondaryBlackColor.withOpacity(0.7)
    ),
      validator: (v) => Validate.validateNormalString(v)

    );
  }
}
