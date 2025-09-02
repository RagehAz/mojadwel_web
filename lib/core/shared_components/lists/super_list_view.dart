import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/utilities/app_scroll_behavior.dart';

class SuperListView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperListView({
    required this.width,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.physics,
    this.bottomPadding = 100,
    this.topPadding = 50,
    this.shrinkWrap = false,
    super.key
  });
  // --------------------
  final double width;
  final double? height;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final int itemCount;
  final double bottomPadding;
  final double topPadding;
  final Widget Function(int index) itemBuilder;
  final bool shrinkWrap;
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
          itemCount: itemCount + 1,
          physics: physics ?? const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: bottomPadding,
          ),
          shrinkWrap: shrinkWrap,
          itemBuilder: (_, index){

            if (index == 0){
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: width,
                height: topPadding,
              );
            }

            else {
              return itemBuilder(index - 1);
            }

          },
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
