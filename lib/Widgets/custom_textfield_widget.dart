// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../Utilities/theme_helper.dart';
// import '../Utilities/text_style_helper.dart';
//
// class CustomTextFieldWidget extends StatelessWidget {
//   final TextEditingController? controller;
//   final bool? obscure;
//   final bool? readOnly;
//   final String? hint;
//   final Color? backGroundColor,focusedBorderColor;
//   final TextStyle? style;
//   final TextStyle? hintStyle;
//   final int? maxLine,minLines;
//   final String? Function(String?)? validator;
//   final TextInputType? textInputType;
//   final bool? enable, isDense;
//   final Color? borderColor;
//   final bool disableBorder;
//   final FocusNode? unitCodeCtrlFocusNode;
//   final double? borderRadiusValue, width, height;
//   final EdgeInsets? insidePadding;
//   final void Function(String?)? onSave;
//   final Widget? prefixIcon, suffixIcon;
//   final void Function(String)? onchange;
//   final Function()? onSuffixTap;
//   final void Function()? onTap;
//   final List<TextInputFormatter>? formatter;
//   final TextInputAction? textInputAction;
//   final bool? expands;
//   const CustomTextFieldWidget({
//     Key? key,
//     this.isDense,
//     this.style,
//     this.onchange,
//     this.insidePadding,
//     this.validator,
//     this.maxLine,
//     this.hint,
//     this.backGroundColor,
//     this.controller,
//     this.obscure = false,
//     this.enable = true,
//     this.readOnly = false,
//     this.textInputType = TextInputType.text,
//     this.borderColor,
//     this.borderRadiusValue,
//     this.prefixIcon,
//     this.width,
//     this.hintStyle,
//     this.suffixIcon,
//     this.onSuffixTap,
//     this.height,
//     this.onTap,
//     this.formatter, this.unitCodeCtrlFocusNode, this.focusedBorderColor, this.onSave, this.minLines,
//     this.disableBorder = false, this.textInputAction,
//     this.expands,
//   }) : super(key: key);
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     InputBorder? getBorder({double? radius,Color? color}){
//       if(disableBorder) return null;
//       return OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radius ?? 28.r),
//         borderSide: BorderSide(color: color ?? ThemeClass.of(context).secondary,width: 1.w),
//       );
//     }
//
//     return SizedBox(
//       width: width,
//       child: TextFormField(
//         textInputAction: textInputAction,
//         onFieldSubmitted: onSave,
//         focusNode:unitCodeCtrlFocusNode ,
//         readOnly: readOnly ?? false,
//         textAlignVertical: TextAlignVertical.center,
//         validator: validator,
//         onTap:  onTap,
//         enabled: enable,
//         inputFormatters: formatter ?? [],
//         obscureText: obscure ?? false,
//         controller: controller,
//         expands: expands??false,
//
//         decoration: InputDecoration(
//           errorStyle: const TextStyle(height: 0),
//           enabledBorder: getBorder(radius: borderRadiusValue,color: borderColor),
//           disabledBorder: getBorder(radius: borderRadiusValue,color: borderColor),
//           focusedBorder: getBorder(radius: borderRadiusValue,color: focusedBorderColor??ThemeClass.of(context).primaryColor),
//           border: getBorder(radius: borderRadiusValue,color: focusedBorderColor),
//           isDense: isDense ?? false,
//           prefixIconConstraints: BoxConstraints(
//               minWidth: prefixIcon == null ? 0 : 48.w, maxHeight: 48.w),
//           suffixIconConstraints: BoxConstraints(
//               minWidth: suffixIcon == null ? 0 : 48.w, maxHeight: 24.h),
//           // contentPadding: insidePadding ?? EdgeInsets.symmetric(vertical: 21.h),
//           fillColor: backGroundColor,
//           filled: backGroundColor != null,
//           hintText: hint,
//           prefixIcon: prefixIcon ?? SizedBox(width: 20.w,),
//           suffixIcon: suffixIcon == null ? SizedBox(width: 5.w,) : InkWell(onTap: onSuffixTap,
//           hoverColor: Colors.transparent,
//           focusColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//             child: SizedBox(width: 30.w,height: 60.h, child: suffixIcon),
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 28.w),
//
//           hintStyle: hintStyle ?? TextStyleHelper.of(context).b_16.copyWith(color: ThemeClass.of(context).secondary),),
//
//         onChanged: onchange,
//         textCapitalization: TextCapitalization.words,
//         maxLines: maxLine ?? 1,
//         minLines:minLines?? 1 ,
//         keyboardType: textInputType,
//         style: style ?? TextStyleHelper.of(context).b_16.copyWith(color: ThemeClass.of(context).secondary),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? hint;
  final Color? backGroundColor, focusedBorderColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLine, minLines;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? enable, isDense;
  final Color? borderColor;
  final bool disableBorder;
  final FocusNode? focusNode;
  final double? borderRadiusValue, width, height;
  final EdgeInsets? insidePadding;
  final void Function(String?)? onSave;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onchange;
  final Function()? onSuffixTap;
  final void Function()? onTap;
  final List<TextInputFormatter>? formatter;
  final TextInputAction? textInputAction;
  final bool? expands;

  const CustomTextFieldWidget({
    Key? key,
    this.isDense,
    this.style,
    this.onchange,
    this.insidePadding,
    this.validator,
    this.maxLine,
    this.hint,
    this.backGroundColor,
    this.controller,
    this.obscure = false,
    this.enable = true,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.borderColor,
    this.borderRadiusValue,
    this.prefixIcon,
    this.width,
    this.hintStyle,
    this.suffixIcon,
    this.onSuffixTap,
    this.height,
    this.onTap,
    this.formatter,
    this.focusNode,
    this.focusedBorderColor,
    this.onSave,
    this.minLines,
    this.disableBorder = false,
    this.textInputAction,
    this.expands,
  }) : super(key: key);

  @override
  CustomTextFieldWidgetState createState() => CustomTextFieldWidgetState();
}

class CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late FocusNode _focusNode;
  bool _isFocused = false;

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

  InputBorder? getBorder({double? radius, Color? color}) {
    if (widget.disableBorder) return null;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 28.r),
      borderSide: BorderSide(
        color: color ?? Theme.of(context).dividerColor,
        width: 1.w,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 48.h,
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.obscure ?? false,
        readOnly: widget.readOnly ?? false,
        enabled: widget.enable,
        maxLines: widget.maxLine ?? 1,
        minLines: widget.minLines ?? 1,
        keyboardType: widget.textInputType,
        style: widget.style ??
            TextStyleHelper.of(context)
                .b_16
                .copyWith(color: ThemeClass.of(context).mainBlack),
        textInputAction: widget.textInputAction,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onSave,
        inputFormatters: widget.formatter?? [],
        expands: widget.expands ?? false,
        onChanged: widget.onchange,
        textAlignVertical: TextAlignVertical.center,
        validator: widget.validator,
        decoration: InputDecoration(
         errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color:ThemeClass.of(context).primaryColor, // Border color when there's an error
              width:1,
            ),
          ),
          //textCapitalization: TextCapitalization.words,
          enabledBorder: getBorder(
            radius: widget.borderRadiusValue,
            color: widget.borderColor,
          ),
          focusedBorder: getBorder(
            radius: widget.borderRadiusValue,
            color: widget.focusedBorderColor ??
                ThemeClass.of(context).primaryColor,
          ),
          fillColor: _isFocused
              ? Colors.transparent
              : widget.backGroundColor ?? Theme.of(context).dividerColor,
          filled: true,
          hintText: widget.hint,
          hintStyle: widget.hintStyle,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 12.w), // Adjust padding if needed
                  child: widget.prefixIcon,
                )
              // SizedBox(
              //         width: 24.w, // Adjust width here
              //         height: 24.h, // Adjust height here
              //         child: widget.prefixIcon,
              //       )
              : null,
           prefixIconConstraints:BoxConstraints( minWidth: widget.prefixIcon == null ? 0.w : 48.w, maxHeight: 48.w),
    //BoxConstraints(
          //   minWidth: 24.w,
          //   minHeight: 24.h,
          //   maxHeight: 24.h,
          // ),
          suffixIconConstraints: BoxConstraints(
           minWidth: widget.suffixIcon == null ? 0 : 48.w, maxHeight:24.h),
            suffixIcon:widget.suffixIcon != null
              ? Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                  child: InkWell(
                    onTap: widget.onSuffixTap,
                    child: widget.suffixIcon,
                  ),
                )
              : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 28.w),
        ),
      ),
    );
  }
}
