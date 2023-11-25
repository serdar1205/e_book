import 'package:flutter/material.dart';

@immutable
class VeryBigText extends Text {
  const VeryBigText(super.data,
      {super.key,  this.fontWeight, required this.context});

  final BuildContext context;

  final FontWeight? fontWeight;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style => Theme.of(context).primaryTextTheme.titleLarge!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int get maxLines => 2;
}

@immutable
class BigText extends Text {
  const BigText(super.data, {super.key, required this.context,});

  final BuildContext context;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style => Theme.of(context).primaryTextTheme.titleMedium!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int get maxLines => 2;
}

@immutable
class MediumText extends Text {
  const MediumText(super.data,
      {super.key,
      this.fontWeight,
      this.bodyText,
      required this.context});

  final BuildContext context;
  final FontWeight? fontWeight;
  final bool? bodyText;

  // final int? maxLine;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style => Theme.of(context).primaryTextTheme.bodyLarge!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

// @override
// int get maxLines => maxLine!;
}

@immutable
class SmallText extends Text {
  const SmallText(super.data,
      {super.key,  this.fontWeight, required this.context});

  final BuildContext context;
  final FontWeight? fontWeight;

  //final int? maxLine;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style => Theme.of(context).primaryTextTheme.bodyMedium!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

// @override
// int get maxLines => maxLine!;
}

@immutable
class VerySmallText extends Text {
  const VerySmallText(super.data,
      {super.key, this.fontWeight, required this.context});

  final BuildContext context;
  final FontWeight? fontWeight;

  //final int? maxLine;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style => Theme.of(context).primaryTextTheme.bodySmall!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int get maxLines => 2;
}
