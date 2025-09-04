import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class ProductModel {
  // -----------------------------------------------------------------------------
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String? name;
  final String? description;
  final double? price;
  final String? currency;
  // --------------------------------------------------------------------------

  /// CONSTANT

  // --------------------
  ///
  static ProductModel empty(){
    return ProductModel(
      id: _Idifier.createUniqueIDString(),
      name: '',
      price: 0,
      description: '',
      currency: 'EGP',
    );
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currency,
  }){
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
    );
  }
  // --------------------
  ///
  ProductModel nullifyField({
    bool name = false,
    bool description = false,
    bool price = false,
    bool currency = false,
  }){
    return ProductModel(
      id: id,
      name: name == true ? null : this.name,
      description: description == true ? null : this.description,
      price: price == true ? 0 : this.price,
      currency: currency == true ? null : this.currency,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
    };
  }
  // --------------------
  ///
  static Map<String, dynamic> cipherToMaps({
    required Map<String, ProductModel>? models,
  }){
    Map<String, dynamic> _output = {};

    final List<String>? _keys = models?.keys.toList();

    if (_checkCanLoop(_keys) == true){

      for (final String productID in _keys!){

        final ProductModel _product = models![productID]!;

        _output = _insertPairInMap(
            map: _output,
            key: productID,
            value: _product.toMap(),
            overrideExisting: true,
        );

      }

    }

    return _output;
  }
  // --------------------
  ///
  static ProductModel? decipherMap({
    required Map<String, dynamic>? map,
  }){
    ProductModel? _output;

    if (map != null){

      _output = ProductModel(
          id: map['id'],
          name: map['name'],
          description: map['description'],
          price: map['price'],
          currency: map['currency'],
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Map<String, ProductModel> decipherMaps({
    required Map<String, dynamic>? map,
   }){
    final Map<String, ProductModel> _output = {};

    final List<String>? _keys = map?.keys.toList();

    if (_checkCanLoop(_keys) == true){

      for (final String productID in _keys!){

        final ProductModel? _model = decipherMap(
          map: map![productID],
        );

        if (_model != null){
          _output[productID] = _model;
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// TO LIST

  // --------------------
  ///
  static List<ProductModel> toList({
    required Map<String, ProductModel>? productsMap,
  }){
    final List<ProductModel> _output = [];

    final List<String>? _productsIDs = productsMap?.keys.toList();

    if (_checkCanLoop(_productsIDs) == true){

      for (final String productID in _productsIDs!){

        if (productsMap?[productID] != null){
          _output.add(productsMap![productID]!);
        }

      }

    }

    return _output;
  }

  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsAreIdentical({
    required ProductModel? model1,
    required ProductModel? model2,
  }){
    return const DeepCollectionEquality().equals(model1?.toMap(), model2?.toMap());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsListsAreIdentical({
    required Map<String, ProductModel>? models1,
    required Map<String, ProductModel>? models2,
  }){
    return const DeepCollectionEquality().equals(models1, models2);
  }
  // -----------------------------------------------------------------------------

  /// HELPERS

  // --------------------
  /// AI TESTED
  static bool _checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic> _insertPairInMap({
    required Map<String, dynamic>? map,
    required String? key,
    required dynamic value,
    required bool overrideExisting, // was always false by default
  }) {

    final Map<String, dynamic> _result = <String, dynamic>{};

    if (map != null){
      _result.addAll(map);
    }

    if (key != null){

      /// PAIR IS NULL
      if (_result[key] == null){
        _result[key] = value;
        // _result.putIfAbsent(key, () => value);
      }

      /// PAIR HAS VALUE
      else {
        if (overrideExisting == true){
          _result[key] = value;
        }
      }

    }

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
ProductModel(
  id: $id,
  name: $name,
  description: $description,
  price: $price,
  currency: $currency,
)  
       ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ProductModel){
      _areIdentical = checkModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      name.hashCode^
      description.hashCode^
      price.hashCode^
      currency.hashCode^
      id.hashCode;
  // -----------------------------------------------------------------------------
}

abstract class _Idifier {
  // --------------------
  /// TESTED : WORKS PERFECT
  static String createUniqueIDString({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }){
    return _createUniqueIDInteger(maxDigitsCount: maxDigitsCount).toString();
  }
  // --------------------
  /// AI TESTED
  static int _createUniqueIDInteger({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }) {
    assert(maxDigitsCount > 0 && maxDigitsCount <= 16, 'Take care : 0 < maxDigitsCount <= 16',);

    /// some smart ass stunt online said : DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String _string = DateTime.now().microsecondsSinceEpoch.toString();

    final String? _trimmed = _removeNumberOfCharactersFromBeginningOfAString(
      string: _string,
      numberOfCharacters: _string.length - maxDigitsCount,
    );

    return _transformStringToInt(_trimmed)!;
  }
  // --------------------
  /// AI TESTED
  static String? _removeNumberOfCharactersFromBeginningOfAString({
    required String? string,
    required int? numberOfCharacters,
  }) {

    if (_isEmpty(string) == true){
      return null;
    }

    else {

      final int _numberOfCharacters = numberOfCharacters ?? 0;

      if (_numberOfCharacters > 0) {

        String? _stringTrimmed;

        if (_numberOfCharacters > string!.length) {
          // blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
          final Error _error = ArgumentError(
              'can not remove ($numberOfCharacters) from the given string because',
              'removeNumberOfCharactersFromBeginningOfAString');
          throw _error;
        }

        else {
          _stringTrimmed = string.isNotEmpty ? string.substring(_numberOfCharacters) : null;
        }

        return _stringTrimmed;
      }

      else {
        return string;
      }

    }
  }
  // --------------------
  /// AI TESTED
  static bool _isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// AI TESTED
  static int? _transformStringToInt(String? string) {
    int? _value;

    if (string != null) {
      final double? _doubleValue = double.tryParse(string);
      _value = _doubleValue?.toInt();
    }

    return _value;
  }
  // -----------------------------------------------------------------------------
}
