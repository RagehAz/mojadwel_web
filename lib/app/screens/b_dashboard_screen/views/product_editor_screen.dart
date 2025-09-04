import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/models/bz_model/product_model.dart';
import 'package:mojadwel_web/core/shared_components/bubble/bubble.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text_field/super_text_field.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

class ProductEditorScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const ProductEditorScreen({
    this.product,
    super.key
  });
  // --------------------
  final ProductModel? product;
  // --------------------
  @override
  _ProductEditorScreenState createState() => _ProductEditorScreenState();
// --------------------------------------------------------------------------
}

class _ProductEditorScreenState extends State<ProductEditorScreen> {
  // --------------------
  late ProductModel _product;
  final FocusNode _nameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final FocusNode _priceNode = FocusNode();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _product = widget.product ?? ProductModel.empty();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _nameNode.dispose();
    _descriptionNode.dispose();
    _priceNode.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> onConfirm() async {

    await Routing.goBack(
      context: context,
      passedData: _product,
    );

  }
  // --------------------
  Future<void> onDelete() async {
    await Routing.goBack(
      context: context,
      passedData: 'delete',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
        child: (ScreenDim screenDim) => Column(
          children: <Widget>[

            _TheTileBody(
              children: (double width){

                return <Widget>[

                  /// ID
                  Disabler(
                    isDisabled: true,
                    disabledOpacity: 0.8,
                    child: SuperTextField(
                      width: width,
                      margins: const EdgeInsets.only(bottom: 10),
                      textColor: Colorz.black,
                      textFont: MojadwelFonts.body,
                      cursorColor: Colorz.black200,
                      initialValue: _product.id,
                    ),
                  ),

                  /// NAME
                  SuperTextField(
                    width: width,
                    margins: const EdgeInsets.only(bottom: 10),
                    textColor: Colorz.black,
                    textFont: MojadwelFonts.body,
                    cursorColor: Colorz.black200,
                    initialValue: _product.name,
                    focusNode: _nameNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (String? text){
                      if (mounted){
                        setState(() {
                          _product = _product.copyWith(
                            name: text,
                          );
                        });
                      }
                    },
                    validator: (String? text){
                      if (text == null || text.isEmpty){
                        return 'The Name is missing';
                      }
                      else {
                        return null;
                      }
                    },
                  ),

                  /// DESCRIPTION
                  SuperTextField(
                    width: width,
                    margins: const EdgeInsets.only(bottom: 10),
                    textColor: Colorz.black,
                    textFont: MojadwelFonts.body,
                    cursorColor: Colorz.black200,
                    initialValue: _product.description,
                    focusNode: _descriptionNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (String? text){
                      if (mounted){
                        setState(() {
                          _product = _product.copyWith(
                            description: text,
                          );
                        });
                      }
                    },
                    validator: (String? text){
                      if (text == null || text.isEmpty){
                        return 'The description is missing';
                      }
                      else {
                        return null;
                      }
                    },
                  ),

                  /// PRICE
                  SuperTextField(
                    width: width,
                    margins: const EdgeInsets.only(bottom: 10),
                    textColor: Colorz.black,
                    textFont: MojadwelFonts.body,
                    cursorColor: Colorz.black200,
                    focusNode: _priceNode,
                    textInputAction: TextInputAction.next,
                    initialValue: _product.price.toString(),
                    onChanged: (String? text){
                      if (mounted){
                        setState(() {
                          _product = _product.copyWith(
                            price: _Helpers.transformStringToDouble(text),
                          );
                        });
                      }
                    },
                    validator: (String? text){
                      if (text == null || text.isEmpty || text == '0'){
                        return 'The price is missing';
                      }
                      else {
                        return null;
                      }
                    },
                  ),

                  /// CURRENCY
                  SuperTextField(
                    width: width,
                    margins: const EdgeInsets.only(bottom: 10),
                    textColor: Colorz.black,
                    textFont: MojadwelFonts.body,
                    cursorColor: Colorz.black200,
                    // textInputAction: TextInputAction.done,
                    onSubmitted: (String? text) async {
                      await onConfirm();
                    },
                    initialValue: _product.currency,
                    onChanged: (String? text){
                      if (mounted){
                        setState(() {
                          _product = _product.copyWith(
                            currency: text,
                          );
                        });
                      }
                    },
                    validator: (String? text){

                      if (text == 'EGP' || text == r'$'){
                        return null;
                      }
                      else {
                        return r'Currency should only be either EGP or $';
                      }

                    },
                  ),

                  /// CONFIRM
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      SuperBox(
                        height: 80,
                        width: width * 0.35,
                        text: 'Delete',
                        textScaleFactor: 0.7,
                        textColor: Colorz.light1,
                        textFont: MojadwelFonts.headline,
                        color: Colorz.bloodTest,
                        onTap: onDelete,
                      ),

                      const Spacing(size: 5),

                      SuperBox(
                        height: 80,
                        width: width * 0.4,
                        text: 'Confirm',
                        textScaleFactor: 0.7,
                        textColor: Colorz.light1,
                        textFont: MojadwelFonts.headline,
                        color: Colorz.black,

                        onTap: onConfirm,
                      ),

                    ],
                  ),

                ];

              },
            ),

          ],
        ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _TheTileBody extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TheTileBody({
    required this.children,
  });
  // --------------------
  final List<Widget> Function(double width) children;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double tileWidth = Scale.theBodyWidth(context) * 0.9;
    // --------------------
    return Container(
      width: context.screenWidth,
      alignment: Alignment.center,
      child: Container(
        width: tileWidth,
        decoration: BoxDecoration(
          color: Colorz.light2,
          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.all(color: Colorz.light3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ICON
            const SuperBox(
              height: 80,
              width: 80,
              icon: Iconz.product,
              iconColor: Colorz.black255,
              iconSizeFactor: 0.4,
            ),

            /// TEXTS
            SizedBox(
              width: tileWidth - 80 - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Spacing(),

                  ...children(tileWidth - 80 - 80),

                  const Spacing(),

                ],
              ),
            ),

            /// LOADING
            const SuperBox(
              height: 80-2,
              width: 80-2,
              iconColor: Colorz.dark1,
              iconSizeFactor: 0.8,
            ),

          ],
        ),
      ),
    );
    // --------------------

    // --------------------
  }
  // -----------------------------------------------------------------------------
}

abstract class _Helpers {
  // --------------------
  /// AI TESTED
  static double? transformStringToDouble(String? string) {
    double? _value;

    if (string != null && string.trim() != '') {
      _value = double.tryParse(string);
    }

    return _value;
  }
  // -----------------------------------------------------------------------------
}
