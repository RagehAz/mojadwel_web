import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojadwel_web/core/layout/the_app_bar/the_app_bar.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';

class TheLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheLayout({
    required this.child,
    this.backgroundColor,
    this.hasAppBar = true,
    this.showMenu = true,
    this.title,
    super.key,
  });
  // --------------------
  final Widget Function(ScreenDim screen) child;
  final Color? backgroundColor;
  final bool hasAppBar;
  final bool showMenu;
  final String? title;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bodyWidth = Scale.theBodyWidth(context);
    final topMargin = context.safeAreaTopPadding;
    final double _appBarHeight = hasAppBar ? Scale.appBarHeight : 0;
    // --------------------
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colorz.light3,
        statusBarColor: Colorz.light3,
        systemNavigationBarDividerColor: Colorz.light3,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colorz.light1,
        appBar: hasAppBar ? TheAppBar(
          title: title,
          showMenu: showMenu,
        ) : null,
        body: Center(
            child: child(ScreenDim(
              screenWidth: context.screenWidth,
              screenHeight: context.screenHeight,
              bodyWidth: _bodyWidth,
              appBarHeight: _appBarHeight,
              bodyHeight: context.screenHeight - (_appBarHeight + topMargin),
              safeAreaTopPadding: topMargin,
            ))
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}



@immutable
class ScreenDim {
  // -----------------------------------------------------------------------------
  const ScreenDim({
    required this.bodyWidth,
    required this.bodyHeight,
    required this.appBarHeight,
    required this.safeAreaTopPadding,
    required this.screenWidth,
    required this.screenHeight,
  });
  // -----------------------------------------------------------------------------
  final double bodyWidth;
  final double bodyHeight;
  final double appBarHeight;
  final double safeAreaTopPadding;
  final double screenWidth;
  final double screenHeight;
  // -----------------------------------------------------------------------------

  /// CLONING

  // // --------------------
  // ///
  // TemplateModel copyWith({
  //   String? id,
  // }){
  //   return TemplateModel(
  //     id: id ?? this.id,
  //   );
  // }
  // // --------------------
  // ///
  // TemplateModel nullifyField({
  //   bool id = false,
  // }){
  //   return TemplateModel(
  //     id: id == true ? '' : this.id,
  //   );
  // }
  // // -----------------------------------------------------------------------------
  //
  // /// CYPHERS
  //
  // // --------------------
  // ///
  // Map<String, dynamic> toMap(){
  //   return {
  //     'id': id,
  //   };
  // }
  // // --------------------
  // ///
  // static List<Map<String, dynamic>> cipherToMaps({
  //   required List<TemplateModel>? models,
  // }){
  //   final List<Map<String, dynamic>> _output = [];
  //
  //   if (Lister.checkCanLoop(models) == true){
  //
  //     for (final TemplateModel model in models!){
  //
  //       final Map<String, dynamic> _map = model.toMap();
  //
  //       _output.add(_map);
  //
  //     }
  //
  //   }
  //
  //   return _output;
  // }
  // // --------------------
  // ///
  // static TemplateModel? decipherMap({
  //   required Map<String, dynamic>? map,
  // }){
  //   TemplateModel? _output;
  //
  //   if (map != null){
  //
  //     _output = TemplateModel(
  //         id: map['id'],
  //     );
  //
  //   }
  //
  //   return _output;
  // }
  // // --------------------
  // ///
  // static List<TemplateModel> decipherMaps({
  //   required List<Map<String, dynamic>>? maps,
  //  }){
  //   final List<TemplateModel> _output = [];
  //
  //   if (Lister.checkCanLoop(maps) == true){
  //
  //     for (final Map<String, dynamic> map in maps!){
  //
  //       final TemplateModel? _model = decipherMap(
  //         map: map,
  //       );
  //
  //       if (_model != null){
  //         _output.add(_model);
  //       }
  //
  //     }
  //
  //   }
  //
  //   return _output;
  // }
  // // -----------------------------------------------------------------------------
  //
  // /// EQUALITY
  //
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static bool checkModelsAreIdentical({
  //   required TemplateModel? model1,
  //   required TemplateModel? model2,
  // }){
  //
  //   return Mapper.checkMapsAreIdentical(
  //       map1: model1?.toMap(),
  //       map2: model2?.toMap(),
  //   );
  // }
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static bool checkModelsListsAreIdentical({
  //   required List<TemplateModel>? models1,
  //   required List<TemplateModel>? models2,
  // }){
  //
  //   return Mapper.checkMapsListsAreIdentical(
  //     maps1: cipherToMaps(models: models1),
  //     maps2: cipherToMaps(models: models2),
  //   );
  // }
  // // -----------------------------------------------------------------------------
  //
  // /// OVERRIDES
  //
  // // --------------------
  // @override
  // String toString() =>
  //     '''
  //      TemplateModel(
  //         id : $id,
  //      )
  //      ''';
  // // --------------------
  // @override
  // bool operator == (Object other){
  //
  //   if (identical(this, other)) {
  //     return true;
  //   }
  //
  //   bool _areIdentical = false;
  //   if (other is TemplateModel){
  //     _areIdentical = checkModelsAreIdentical(
  //       model1: this,
  //       model2: other,
  //     );
  //   }
  //
  //   return _areIdentical;
  // }
  // // --------------------
  // @override
  // int get hashCode =>
  //     id.hashCode;
  // -----------------------------------------------------------------------------
}
