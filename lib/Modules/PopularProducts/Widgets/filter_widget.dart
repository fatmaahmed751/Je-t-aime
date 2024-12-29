import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../Models/category_model.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import '../../../generated/assets.dart';

class ProductFilter extends StatefulWidget {
  final Function(int?, int?, List, List) onApply;
  final TextEditingController startController;
  final TextEditingController endController;
  final bool autoValidate;
  final Function() onAutoValidate;

  const ProductFilter(
      {super.key,
      required this.onApply,
      required this.startController,
      required this.endController,
    required this.autoValidate, required this.onAutoValidate});

  @override
  State<ProductFilter> createState() => _TournamentFilterWidgetState();
}

class _TournamentFilterWidgetState extends State<ProductFilter> {
  // List<BannerModel> rates = [
  //   BannerModel(id: 5, isFavourite: false),
  //   BannerModel(id: 4, isFavourite: false),
  //   BannerModel(id: 3, isFavourite: false),
  //   BannerModel(id: 2, isFavourite: false),
  //   BannerModel(id: 1, isFavourite: false),
  // ];
  List ratesIds = [];
  List categoryIds = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey ,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(32.h),
            Text(
              Strings.price.tr,
              style: TextStyleHelper.of(context)
                  .h_20
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    width: 165.w,
                    height: 48.h,
                    //isDense: true,
                    insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                    backGroundColor: ThemeClass.of(context).labelColor,
                    controller: widget.startController,
                  //  validator: (v) => Validate.validateNormalFilterNumber(v),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    ":",
                    style: TextStyleHelper.of(context)
                        .h_20
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: CustomTextFieldWidget(
                    width: 165.w,
                    height: 48.h,
                    // isDense: true,
                    insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                    backGroundColor: ThemeClass.of(context).labelColor,
                    controller: widget.endController,
                    validator: (v) => Validate.validateFilterNumber(v,widget.startController.text),
                  ),
                ),
              ],
            ),
            Gap(20.h),
            Text(
              Strings.categories.tr,
              style: TextStyleHelper.of(context)
                  .h_20
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Gap(16.h),
            GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Three columns
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: (90.w /
                    41.h), // Adjust as needed for your desired aspect ratio
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
               // final e = widget.categories[index];
                return InkWell(
                  onTap: () {
                   //  e.isSelected = !e.isSelected;
                   //  if (!categoryIds.contains(e.id) &&
                   //      e.isSelected == true) {
                   //    categoryIds.add(e.id);
                   //  }
                   //  setState(() {
                   //  });
                   //  print("is Selected${e.isSelected}");
                   //  print("is categoryIds${categoryIds.length}");
                   //  // print("<<<<1${categoryIds.length}");
                   //  // if (e.id != 0) {
                   //  //   widget.categories.map((e) {
                   //  //     if(e.id==widget.se)
                   //  //     print("<<<<${categoryIds.length}");
                   //  //   }).toList();
                   //  //   setState(() {
                   //  //   });
                   // // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color:categoryIds.contains(2)?ThemeClass.of(context).primaryColor: ThemeClass.of(context).secondary),
                    ),
                    padding: EdgeInsets.all(10.r),
                    child: Center(
                      child: Text(
                        "name",
                      //  e.name ?? '',
                        style: TextStyleHelper.of(context).h_16.copyWith(
                            fontWeight: FontWeight.w500,
                            color:categoryIds.contains(1)?ThemeClass.of(context).labelColor: ThemeClass.of(context).secondary),
                      ),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              // Prevents the GridView from expanding infinitely
              physics:
                  const NeverScrollableScrollPhysics(), // Allows GridView to fit within its parent
            ),
            Gap(20.h),
            Text(
              Strings.rate.tr,
              style: TextStyleHelper.of(context)
                  .h_20
                  .copyWith(fontWeight: FontWeight.w500),
            ),

            Gap(32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonWidget.secondary(
                  width: 155.w,
                  title: Strings.cancel.tr,
                  onTap: () => context.pop(),
                  textStyle: TextStyleHelper.of(context)
                      .h_20
                      .copyWith(color: ThemeClass.of(context).primaryColor),
                ),
                Gap(16.w),
                CustomButtonWidget.primary(
                  width: 155.w,
                  title: Strings.apply.tr,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      widget.onApply(
                          widget.startController.text.isNotEmpty?int.parse(widget.startController.text):null,
                          widget.endController.text.isNotEmpty?int.parse(widget.endController.text):null,
                          categoryIds,
                          ratesIds);
                      widget.startController.text='';
                      widget.endController.text='';
                    } else {
                      widget.onAutoValidate();
                    }

                  },
                  textStyle: TextStyleHelper.of(context).h_20,
                ),
              ],
            ),
            Gap(28.h),
          ],
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final void Function(bool?)? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.isChecked,
    this.onChanged,
  }) : super(key: key);

  @override
  CustomCheckboxState createState() => CustomCheckboxState();
}

class CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
           _isChecked = !_isChecked;
           widget.onChanged?.call(_isChecked);
          //e.isFavourite = newValue!;
        });
      },
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          border: Border.all(
              color: ThemeClass.of(context).primaryColor.withOpacity(.5)),
          borderRadius: BorderRadius.circular(1),
          color:ThemeClass.of(context).background
          // _isChecked
          //     ? ThemeClass.of(context).primaryColor
          //     : ThemeClass.of(context).background,
        ),
        child: _isChecked
            ?  Icon(
                Icons.check,
                color: ThemeClass.of(context).primaryColor,
                size: 16,
              )
            : null,
      ),
    );
  }
}
