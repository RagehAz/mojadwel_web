import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/utilities/app_scroll_behavior.dart';

import '../super_text_field/super_text_field.dart';

class VerticalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VerticalFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding = EdgeInsets.zero,
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ScrollConfiguration(
      behavior: const AppScrollBehavior(),
      child: SingleChildScrollView(
        physics: physics,
        controller: scrollController,
        child: Container(
          width: width ?? Scale.screenWidth(context),
          constraints: BoxConstraints(
            minHeight: height ?? Scale.screenHeight(context),
          ),
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: HorizontalFloatingList._superCorners(corners: boxCorners),
              border: borderColor == null ? null :
              Border.all(
                width: 0.5,
                color: borderColor!,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
          ),
          alignment: boxAlignment,
          padding: padding,
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class SuperHorizontalListView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperHorizontalListView({
    required this.width,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.physics,
    this.horizontalPadding = 10,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final int itemCount;
  final double horizontalPadding;
  final Widget Function(int index) itemBuilder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SizedBox(
      width: width,
      height: height,
      child: ScrollConfiguration(
        behavior: const AppScrollBehavior(),
        child: ListView.builder(
          controller: controller,
          itemCount: itemCount,
          physics: physics ?? const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          cacheExtent: width * 2,
          itemBuilder: (_, index){

            return itemBuilder(index);

          },
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class HorizontalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HorizontalFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding = EdgeInsets.zero,
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius _superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = _cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius _cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// CAUTION : IF YOU CHANGE THIS,, IT IMPACTS ShelfSlidesPart() WIDGET, TAKE CARE
    return Container(
      height: height ?? Scale.screenHeight(context),
      width: width,
      // constraints: BoxConstraints(
      //   minWidth: width ?? Scale.screenWidth(context),
      // ),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: _superCorners(corners: boxCorners),
      ),
      alignment: boxAlignment,
      child: ScrollConfiguration(
        behavior: const AppScrollBehavior(),
        child: SingleChildScrollView(
          physics: physics,
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          padding: padding,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
