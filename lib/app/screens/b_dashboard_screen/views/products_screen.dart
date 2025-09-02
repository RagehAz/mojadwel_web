import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/profile_tile.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dashboard_controller.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/models/bz_model/product_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/bubble/bubble.dart';
import 'package:mojadwel_web/core/shared_components/lists/super_list_view.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

class ProductsScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const ProductsScreen({
    required this.controller,
    super.key
  });
  // --------------------
  final DashboardController controller;
  // --------------------
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
  // --------------------------------------------------------------------------
}

class _ProductsScreenState extends State<ProductsScreen> {
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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<ProductModel> _products = ProductModel.toList(
      productsMap: widget.controller.userModel?.products,
    );

    _products.add(const ProductModel(id: 'id', name: 'name', description: 'description', price: 120.55, currency: 'EGP'));

    // --------------------
    return TheLayout(
        child: (ScreenDim screen) => SuperListView(
          width: screen.screenWidth,
          height: screen.bodyHeight,
          itemCount: _products.length + 1,
          itemBuilder: (int index){

            if (_products.length == index){

              return TheTile(
                headline: ' ',
                value: 'Add product',
                bigIcon: true,
                icon: '+',
                onTap: (){
                  blog('should add product');
                },
              );

            }

            else {

              final ProductModel _product = _products[index];

              return TheTile(
                headline: _product.id,
                value: _product.name,
                icon: Iconz.product,
                bigIcon: true,
                onTap: (){
                  blog('product is tapped id(${_product.id})');
                },
              );

            }


          },
        ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class ProductTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ProductTile({
    required this.productModel,
    super.key
  });
  // --------------------
  final ProductModel productModel;
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
        height: 100,
        decoration: BoxDecoration(
          color: Colorz.light2,
          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.all(color: Colorz.light3),
        ),

      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class ThePlusTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ThePlusTile({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double tileWidth = Scale.theBodyWidth(context) * 0.9;
    // --------------------
    return Container(
      width: tileWidth,
      height: 100,
      color: Colorz.bloodTest,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
