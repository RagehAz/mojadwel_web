import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/utilities/timers.dart';

@immutable
class BusinessModel {
  // -----------------------------------------------------------------------------
  const BusinessModel({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.email,
    required this.phone,
    required this.plan,
    required this.createdAt,
    required this.trialEndsAt,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String businessName;
  final String ownerName;
  final String? email;
  final String phone;
  final String plan;
  final DateTime? createdAt;
  final DateTime? trialEndsAt;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  BusinessModel copyWith({
    String? id,
    String? businessName,
    String? ownerName,
    String? email,
    String? phone,
    String? plan,
    DateTime? createdAt,
    DateTime? trialEndsAt,
  }){
    return BusinessModel(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      plan: plan ?? this.plan,
      createdAt: createdAt ?? this.createdAt,
      trialEndsAt: trialEndsAt ?? this.trialEndsAt,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap({
    required bool toJSON,
  }){
    return {
      'id': id,
      'businessName': businessName,
      'ownerName': ownerName,
      'email': email,
      'phone': phone,
      'plan': plan,
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'trialEndsAt': Timers.cipherTime(time: trialEndsAt, toJSON: toJSON),
    };
  }
  // --------------------
  ///
  static List<Map<String, dynamic>> cipherToMaps({
    required List<BusinessModel>? models,
    required bool toJSON,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (_checkCanLoop(models) == true){

      for (final BusinessModel model in models!){

        final Map<String, dynamic> _map = model.toMap(
          toJSON: toJSON,
        );

        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  ///
  static BusinessModel? decipherMap({
    required Map<String, dynamic>? map,
    required bool fromJSON,
  }){
    BusinessModel? _output;

    if (map != null){

      _output = BusinessModel(
        id: map['id'],
        businessName: map['businessName'],
        ownerName: map['ownerName'],
        email: map['email'],
        phone: map['phone'],
        plan: map['plan'],
        createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        trialEndsAt: Timers.decipherTime(time: map['trialEndsAt'], fromJSON: fromJSON),
      );

    }

    return _output;
  }
  // --------------------
  ///
  static List<BusinessModel> decipherMaps({
    required List<Map<String, dynamic>>? maps,
    required bool fromJSON,
   }){
    final List<BusinessModel> _output = [];

    if (_checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final BusinessModel? _model = decipherMap(
          map: map,
          fromJSON: fromJSON,
        );

        if (_model != null){
          _output.add(_model);
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
    required BusinessModel? model1,
    required BusinessModel? model2,
  }){

    return _checkMapsAreIdentical(
        map1: model1?.toMap(toJSON: true),
        map2: model2?.toMap(toJSON: true),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsListsAreIdentical({
    required List<BusinessModel>? models1,
    required List<BusinessModel>? models2,
  }){
    return _checkMapsListsAreIdentical(
      maps1: cipherToMaps(models: models1, toJSON: true),
      maps2: cipherToMaps(models: models2, toJSON: true),
    );
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
  static bool _checkMapsAreIdentical({
    required Map<String, dynamic>? map1,
    required Map<String, dynamic>? map2,
  }) {

    return const DeepCollectionEquality().equals(map1, map2);

    /*
    bool _mapsAreIdentical = false;

    /// BOTH ARE NULL
    if (map1 == null && map2 == null) {
      _mapsAreIdentical = true;
    }

    /// BOTH AREN'T NULL BUT AT LEAST ONE OF THEM IS NULL
    else if (map1 == null || map2 == null){
      _mapsAreIdentical = false;
    }

    /// NON OF THEM IS NULL
    else if (map1 != null && map2 != null){

      if (map1.toString() == map2.toString()){
        _mapsAreIdentical = true;
      }
      else {
        _mapsAreIdentical = false;
      }

      // final List<String> _map1Keys = map1.keys.toList();
      // final List<String> _map2Keys = map2.keys.toList();
      //
      // /// KEYS LENGTH ARE DIFFERENT
      // if (_map1Keys.length != _map2Keys.length) {
      //   _mapsAreIdentical = false;
      // }
      //
      // /// KEYS LENGTH ARE IDENTICAL
      // else {
      //
      //   /// FOR EACH PAIR
      //   for (int i = 0; i < _map1Keys.length; i++){
      //
      //     final String _key1 = _map1Keys[i];
      //     final String _key2 = _map1Keys[i];
      //
      //     /// KEYS ARE DIFFERENT
      //     if (_key1 != _key2){
      //       _mapsAreIdentical = false;
      //       break;
      //     }
      //
      //     /// KEYS ARE IDENTICAL
      //     else {
      //
      //       /// BOTH VALUES ARE NULL
      //       if (map1[_key1] == null && map2[_key2] == null){
      //         // continue looping
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL BUT ONE OF THEM IS
      //       else if (map1[_key1] == null || map2[_key2] == null){
      //         _mapsAreIdentical = false;
      //         break;
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL
      //       else {
      //
      //         /// VALUE TYPES ARE DIFFERENT
      //         if (map1[_key1].runtimeType != map2[_key2].runtimeType){
      //           _mapsAreIdentical = false;
      //           break;
      //         }
      //
      //         /// VALUE TYPES ARE IDENTICAL
      //         else {
      //
      //           if (
      //               map1[_key1] is String ||
      //               map1[_key1] is int ||
      //               map1[_key1] is double ||
      //               map1[_key1] is bool
      //           ){
      //
      //             if (map1[_key1] != map2[_key2]){
      //               _mapsAreIdentical = false;
      //               break;
      //             }
      //
      //           }
      //
      //           else if (map1[_key1] is List){
      //
      //           }
      //
      //         }
      //
      //       }
      //
      //
      //     }
      //
      //   }
      //
      //   // final List<dynamic> _map1Values = map1.values.toList();
      //   // final List<dynamic> _map2Values = map2.values.toList();
      //   //
      //   // if (
      //   //     checkListsAreIdentical(list1: _map1Keys, list2: _map2Keys) == true
      //   //     &&
      //   //     checkListsAreIdentical(list1: _map1Values, list2: _map2Values) == true
      //   // ){
      //   //   _mapsAreIdentical = true;
      //   // }
      //   //
      //   // else {
      //   //   _mapsAreIdentical = false;
      //   // }
      //
      // }

    }

    return _mapsAreIdentical;
     */
  }
  // --------------------
  /// AI TESTED
  static bool _checkMapsListsAreIdentical({
    required List<Map<String, dynamic>>? maps1,
    required List<Map<String, dynamic>>? maps2,
  }){
        /// ITERATE AND DEEP CHECK
    bool _listsAreIdentical = false;

    if (maps1 == null && maps2 == null){
      _listsAreIdentical = true;
    }
    else if (maps1 != null && maps1.isEmpty == true && maps2 != null && maps2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (_checkCanLoop(maps1) == true && _checkCanLoop(maps2) == true){

      if (maps1!.length != maps2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( ${list1.toString()} )');
        // blog(' ---> lis2 is ( ${list2.toString()} )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < maps1.length; i++) {

          if (_checkMapsAreIdentical(map1: maps1[i], map2: maps2[i]) == false){
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (maps1[i].toString() == maps2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
       TemplateModel(
          id : $id,
       )  
       ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is BusinessModel){
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
      id.hashCode;
  // -----------------------------------------------------------------------------
}
