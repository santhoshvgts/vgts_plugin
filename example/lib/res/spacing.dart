
import 'package:flutter/material.dart';
import 'dimens.dart';

class HorizontalSpacing extends StatelessWidget {

  final double spacing;

  HorizontalSpacing._(this.spacing,);

  factory HorizontalSpacing.d2px(){
    return HorizontalSpacing._(AppDimens.d2px,);
  }

  factory HorizontalSpacing.d5px(){
    return HorizontalSpacing._(AppDimens.d5px,);
  }

  factory HorizontalSpacing.d10px(){
    return HorizontalSpacing._(AppDimens.d10px,);
  }

  factory HorizontalSpacing.d20px(){
    return HorizontalSpacing._(AppDimens.d20px,);
  }

  factory HorizontalSpacing.d40px(){
    return HorizontalSpacing._(AppDimens.d40px,);
  }

  factory HorizontalSpacing.custom({required double value}){
    return HorizontalSpacing._(value,);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: EdgeInsets.only(left: spacing));
  }

}



class VerticalSpacing extends StatelessWidget {

  final double spacing;

  VerticalSpacing._(this.spacing,);

  factory VerticalSpacing.d2px(){
    return VerticalSpacing._(AppDimens.d2px,);
  }

  factory VerticalSpacing.d5px(){
    return VerticalSpacing._(AppDimens.d5px,);
  }

  factory VerticalSpacing.d10px(){
    return VerticalSpacing._(AppDimens.d10px,);
  }

  factory VerticalSpacing.d15px(){
    return VerticalSpacing._(AppDimens.d15px,);
  }

  factory VerticalSpacing.d20px(){
    return VerticalSpacing._(AppDimens.d20px,);
  }
  factory VerticalSpacing.d30px(){
    return VerticalSpacing._(AppDimens.d30px,);
  }

  factory VerticalSpacing.d40px(){
    return VerticalSpacing._(AppDimens.d40px,);
  }

  factory VerticalSpacing.custom({required double value}){
    return VerticalSpacing._(value,);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: EdgeInsets.only(top: spacing));
  }

}