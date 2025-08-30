import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/utilities/app_scroll_behavior.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';

class VerticalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VerticalFloatingList({
    required this.children,
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
  final List<Widget>? children;
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
              ...?children,
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

class SingleChildScrollViewX extends StatelessWidget {

  const SingleChildScrollViewX({
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.physics,
    this.reverse = false,
    this.padding,
    this.primary = false,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.skip = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Axis scrollDirection;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool primary;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final bool skip;

  @override
  Widget build(BuildContext context) {

    if (skip == true){
      return child;
    }

    else {
      return ScrollConfiguration(
        behavior: const AppScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: scrollDirection,
          controller: controller,
          physics: physics,
          reverse: reverse,
          padding: padding,
          primary: primary,
          clipBehavior: clipBehavior,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          child: child,
        ),
      );
    }

  }

}
