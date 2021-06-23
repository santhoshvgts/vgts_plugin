
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';

import 'colors.dart';
import 'fontsize.dart';


class AppStyle {

  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColor.primary,
    primaryColorDark: AppColor.primaryDark,
    accentColor: AppColor.accent,
    dividerColor: AppColor.black10,
    brightness: Brightness.light,
    indicatorColor: AppColor.primaryDark,
    textTheme: TextTheme(
        button: TextStyle(color: AppColor.primary)
    ),
    primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: AppColor.black
    ),
    appBarTheme: AppBarTheme().copyWith(
      color: AppColor.white,
      brightness: Brightness.dark,
    ),
    backgroundColor: AppColor.background,
    fontFamily: "GeneralSans",
    scaffoldBackgroundColor: AppColor.background,
  );

  static final List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black12, spreadRadius: 0.3, blurRadius: 5),
  ];

  static final Widget mildDivider = Container(height:1,child:Divider(color: AppColor.black10, thickness: 1,));
  static final Widget divider = Divider(color: AppColor.text, thickness: 1,);

  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 1),
  ];

  static final cardDecoration =  BoxDecoration(
  color: AppColor.white,
  border: Border.all(color: AppColor.black10,width: 2),
  borderRadius: BorderRadius.all(Radius.circular(12.0))
  );

  static List<Shadow> textShadow = <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Colors.black12,
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.black12,
    ),
  ];

  static setSystemUIOverlayStyle(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColor.labelText,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColor.black,
        systemNavigationBarIconBrightness: Brightness.light));
  }

  static FormFieldConfig editTextFieldConfig = FormFieldConfig(
      textStyle: AppTextStyle.subtitleRegular,
      labelStyle: AppTextStyle.captionMedium,
      errorStyle: AppTextStyle.captionMedium,
      optionalStyle: AppTextStyle.captionRegular,
      fillColor: AppColor.secondaryBackground,
      focusColor: AppColor.primary,
      errorColor: Colors.red,
      type: FormInputDecorationType.Box,
      formInputLabelUIType: FormInputLabelUIType.Style1,
      borderColor: AppColor.secondaryBackground,
      borderRadius: BorderRadius.circular(10)
  );
}

class AppTextStyle {

  static const TextStyle appBarTitle = TextStyle(
    fontSize: AppFontSize.dp24,
    fontWeight: FontWeight.w600,
    color: AppColor.text,
  );

  static const TextStyle headerMedium = TextStyle(
    fontSize: AppFontSize.dp28,
    fontWeight: FontWeight.w600,
    color: AppColor.text
  );

  static const TextStyle headerSemiBold = TextStyle(
      fontSize: AppFontSize.dp28,
      fontWeight: FontWeight.w800,
      color: AppColor.text
  );

  static const TextStyle subHeaderMedium = TextStyle(
      fontSize: AppFontSize.dp24,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );

  static const TextStyle titleMedium = TextStyle(
      fontSize: AppFontSize.dp20,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );

  static const TextStyle subtitleMedium = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );

  static const TextStyle subtitleRegular = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );

  static const TextStyle subtitleSemiBold = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w800,
      color: AppColor.text
  );

  static const TextStyle bodyMedium = TextStyle(
      fontSize: AppFontSize.dp14,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );
  static const TextStyle bodyRegular = TextStyle(
      fontSize: AppFontSize.dp14,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );

  static const TextStyle bodySemiBold = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w800,
      color: AppColor.text
  );

  static const TextStyle captionRegular = TextStyle(
    fontSize: AppFontSize.dp12,
    fontWeight: FontWeight.w400,
    color: AppColor.text,
  );

  static const TextStyle captionMedium = TextStyle(
    fontSize: AppFontSize.dp12,
    fontWeight: FontWeight.w600,
    color: AppColor.text,
  );

  static const TextStyle overLine = TextStyle(
    fontSize: AppFontSize.dp10,
    fontWeight: FontWeight.w500,
    color: AppColor.secondaryText,
  );

  static const TextStyle button = TextStyle(
      fontSize: AppFontSize.dp14,
      fontWeight: FontWeight.w600,
      color: AppColor.white
  );

  static const TextStyle button2 = TextStyle(
      fontSize: AppFontSize.dp12,
      fontWeight: FontWeight.w600,
      color: AppColor.primary
  );




//  static const TextStyle header = TextStyle(
//    fontSize: AppFontSize.xlarge,
//    fontWeight: FontWeight.bold,
//    color: AppColor.header,
//  );
//
//  static const TextStyle listHeader = TextStyle(
//    fontSize: AppFontSize.large,
//    fontWeight: FontWeight.w600,
//    color: AppColor.header,
//  );
//
//  static const TextStyle subHeader = TextStyle(
//    fontSize: AppFontSize.title,
//    fontWeight: FontWeight.w600,
//    color: AppColor.primary,
//  );
//  static const TextStyle listSubHeader = TextStyle(
//    fontSize: AppFontSize.medium,
//    fontWeight: FontWeight.w600,
//    color: AppColor.header,
//  );
//
//  static const TextStyle quantity = TextStyle(
//    fontSize: AppFontSize.smaller,
//    fontWeight: FontWeight.normal,
//    color: AppColor.secondaryText,
//  );
//
//  static const TextStyle body = TextStyle(
//      fontSize: AppFontSize.small,
//      fontWeight: FontWeight.normal,
//      color: AppColor.header,
//      height: 1.5
//  );
//  static const TextStyle ShopListHeader = TextStyle(
//      fontSize: AppFontSize.large,
//      fontWeight: FontWeight.w600,
//      color: AppColor.header,
//      height: 1.5
//  );
//  static const TextStyle ShopListDesc = TextStyle(
//      fontSize: AppFontSize.small,
//      fontWeight: FontWeight.normal,
//      color: AppColor.descColor,
//      height: 1.5
//  );
//  static const TextStyle ShopStatus = TextStyle(
//      fontSize: AppFontSize.smallest,
//      fontWeight: FontWeight.normal,
//      color: AppColor.primary,
//      height: 1.5
//  );
//
//  static const TextStyle button = TextStyle(
//    fontSize: AppFontSize.largest,
//    fontWeight:FontWeight.bold ,
//    color: AppColor.white,
//  );
//
//  static const TextStyle buttonOutline = TextStyle(
//    fontSize: AppFontSize.largest,
//    fontWeight: FontWeight.bold,
//    color: AppColor.primary,
//  );
//
//  static const TextStyle buttonTextSecondary = TextStyle(
//    fontSize: AppFontSize.small,
//    fontWeight: FontWeight.normal,
//    color: AppColor.white,
//  );
//
//  static const TextStyle buttonSecondary = TextStyle(
//    fontSize: AppFontSize.normal,
//    fontWeight: FontWeight.bold,
//    color: AppColor.secondary,
//  );
//
//  static const TextStyle dialogButtonOutline = TextStyle(
//    fontSize: AppFontSize.small,
//    fontWeight: FontWeight.normal,
//    color: AppColor.primary,
//  );
//
//  static const TextStyle dialogButton = TextStyle(
//    fontSize: AppFontSize.small,
//    fontWeight: FontWeight.normal,
//    color: AppColor.white,
//  );
//
//  static const TextStyle labelChange = TextStyle(
//      fontSize: AppFontSize.smallest,
//      fontWeight: FontWeight.normal,
//      color: AppColor.secondaryText,
//      height: 1.5
//  );
//  static const TextStyle label = TextStyle(
//      fontSize: AppFontSize.smallest,
//      fontWeight: FontWeight.normal,
//      color: AppColor.primary,
//      height: 1.5
//  );
//
//  static const TextStyle text = TextStyle(
//      fontSize: AppFontSize.large,
//      fontWeight: FontWeight.normal,
//      color: AppColor.text,
//      height: 1.5
//  );
//
//  static const TextStyle title = TextStyle(
//      fontSize: AppFontSize.large,
//      fontWeight: FontWeight.bold,
//      color: AppColor.primaryDark,
//      height: 1.5
//  );
//
//  static const TextStyle HeaderText = TextStyle(
//    fontSize: AppFontSize.largest,
//    fontWeight: FontWeight.w600,
//    color: AppColor.primary,
//  );
//  static const TextStyle OrderHeader = TextStyle(
//    fontSize: AppFontSize.title,
//    fontWeight: FontWeight.bold,
//    color: AppColor.orderColor,
//  );
//  static const TextStyle OrderDesc = TextStyle(
//    fontSize: AppFontSize.normal,
//    fontWeight: FontWeight.normal,
//    color: AppColor.descColor,
//  );
//  static const TextStyle whiteColor = TextStyle(
//    fontSize: AppFontSize.large,
//    fontWeight: FontWeight.normal,
//    color: AppColor.white,
//  );
//  static const TextStyle whiteColorBold = TextStyle(
//    fontSize: AppFontSize.large,
//    fontWeight: FontWeight.bold,
//    color: AppColor.white,
//  );
//  static const TextStyle Desc = TextStyle(
//    fontSize: AppFontSize.largest,
//    fontWeight: FontWeight.bold,
//    color: AppColor.primary,
//  );
}