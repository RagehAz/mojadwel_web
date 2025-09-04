import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/models/bz_model/product_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/utilities/timers.dart';

enum AccountStatus {
 active,
 inactive,
}

enum AgentStatus {
  authenticated,
  unauthenticated,
}

class StatusModelling {

  static String? accountStatusToString(AccountStatus? status){
    switch(status){
      case AccountStatus.active:    return 'active';
      case AccountStatus.inactive:  return 'inactive';
      default: return null;
    }
  }

  static AccountStatus? accountStatusFromString(String? value) {
    switch (value) {
      case 'active':    return AccountStatus.active;
      case 'inactive':  return AccountStatus.inactive;
      default:          return null;
    }
  }

  static String? agentStatusToString(AgentStatus? status) {
    switch (status) {
      case AgentStatus.authenticated:     return 'authenticated';
      case AgentStatus.unauthenticated:   return 'unauthenticated';
      default:                            return null;
    }
  }

  static AgentStatus? agentStatusFromString(String? value) {
    switch (value) {
      case 'authenticated':     return AgentStatus.authenticated;
      case 'unauthenticated':   return AgentStatus.unauthenticated;
      default:                  return null;
    }
  }

}

@immutable
class BzModel {
  // -----------------------------------------------------------------------------
  const BzModel({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.email,
    required this.phone,
    required this.plan,
    required this.createdAt,
    required this.trialEndsAt,
    required this.authModel,
    required this.extraBzInfo,
    required this.aiInstructions,
    required this.products,
    required this.accountStatus,
    required this.agentStatus,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String? businessName;
  final String? ownerName;
  final String? email;
  final String? phone;
  final String? plan;
  final DateTime? createdAt;
  final DateTime? trialEndsAt;
  final AuthModel? authModel;
  final String? extraBzInfo;
  final String? aiInstructions;
  final Map<String, ProductModel>? products;
  final AccountStatus? accountStatus;
  final AgentStatus? agentStatus;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  BzModel copyWith({
    String? id,
    String? businessName,
    String? ownerName,
    String? email,
    String? phone,
    String? plan,
    DateTime? createdAt,
    DateTime? trialEndsAt,
    AuthModel? authModel,
    String? extraBzInfo,
    String? aiInstructions,
    Map<String, ProductModel>? products,
    AccountStatus? accountStatus,
    AgentStatus? agentStatus,
  }){
    return BzModel(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      plan: plan ?? this.plan,
      createdAt: createdAt ?? this.createdAt,
      trialEndsAt: trialEndsAt ?? this.trialEndsAt,
      authModel: authModel ?? this.authModel,
      extraBzInfo: extraBzInfo ?? this.extraBzInfo,
      aiInstructions: aiInstructions ?? this.aiInstructions,
      products: products ?? this.products,
      accountStatus: accountStatus ?? this.accountStatus,
      agentStatus: agentStatus ?? this.agentStatus,
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
      'authModel': authModel?.toMap(),
      'extraBzInfo': extraBzInfo,
      'aiInstructions': aiInstructions,
      'products': ProductModel.cipherToMaps(models: products),
      'accountStatus': StatusModelling.accountStatusToString(accountStatus),
      'agentStatus': StatusModelling.agentStatusToString(agentStatus),
    };
  }
  // --------------------
  ///
  static List<Map<String, dynamic>> cipherToMaps({
    required List<BzModel>? models,
    required bool toJSON,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (_checkCanLoop(models) == true){

      for (final BzModel model in models!){

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
  static BzModel? decipherMap({
    required Map<String, dynamic>? map,
    required bool fromJSON,
  }){
    BzModel? _output;

    if (map != null){

      _output = BzModel(
        id: map['id'],
        businessName: map['businessName'],
        ownerName: map['ownerName'],
        email: map['email'],
        phone: map['phone'],
        plan: map['plan'],
        createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        trialEndsAt: Timers.decipherTime(time: map['trialEndsAt'], fromJSON: fromJSON),
        authModel: AuthModel.decipher(map: map['authModel'], userID: map['id']),
        extraBzInfo: map['extraBzInfo'],
        aiInstructions: map['aiInstructions'],
        products: ProductModel.decipherMaps(map: map['products']),
        accountStatus: StatusModelling.accountStatusFromString(map['accountStatus']),
        agentStatus: StatusModelling.agentStatusFromString(map['agentStatus']),
      );

    }

    return _output;
  }
  // --------------------
  ///
  static List<BzModel> decipherMaps({
    required List<Map<String, dynamic>>? maps,
    required bool fromJSON,
   }){
    final List<BzModel> _output = [];

    if (_checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final BzModel? _model = decipherMap(
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
    required BzModel? model1,
    required BzModel? model2,
  }){

    return _checkMapsAreIdentical(
        map1: model1?.toMap(toJSON: true),
        map2: model2?.toMap(toJSON: true),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsListsAreIdentical({
    required List<BzModel>? models1,
    required List<BzModel>? models2,
  }){
    return _checkMapsListsAreIdentical(
      maps1: cipherToMaps(models: models1, toJSON: true),
      maps2: cipherToMaps(models: models2, toJSON: true),
    );
  }
  // -----------------------------------------------------------------------------

  /// EDITORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel? insertProduct({
    required BzModel? bzModel,
    required ProductModel? product,
  }){
    BzModel? _output = bzModel;

    if (product != null && _output != null){

      final Map<String, ProductModel> _productsMap = {..._output.products ?? {}};

      _productsMap[product.id] = product;

      _output = _output.copyWith(
        products: _productsMap,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel? deleteProduct({
    required BzModel? bzModel,
    required ProductModel? product,
  }){
    BzModel? _output = bzModel;

    if (product != null && _output != null){

      final Map<String, ProductModel> _productsMap = {..._output.products ?? {}};

      _productsMap.remove(product.id);

      _output = _output.copyWith(
        products: _productsMap,
      );

    }

    return _output;
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
UserModel(
  id: $id,
  businessName: $businessName,
  ownerName: $ownerName,
  email: $email,
  phone: $phone,
  plan: $plan,
  createdAt: $createdAt,
  trialEndsAt: $trialEndsAt,
  authModel: $authModel,
  extraBzInfo: $extraBzInfo,
  aiInstructions: $aiInstructions,
  products: $products,
  accountStatus: $accountStatus,
  agentStatus: $agentStatus,
)  
''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is BzModel){
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
      id.hashCode^
      businessName.hashCode^
      ownerName.hashCode^
      email.hashCode^
      phone.hashCode^
      plan.hashCode^
      createdAt.hashCode^
      trialEndsAt.hashCode^
      extraBzInfo.hashCode^
      aiInstructions.hashCode^
      products.hashCode^
      accountStatus.hashCode^
      agentStatus.hashCode^
      authModel.hashCode;
  // -----------------------------------------------------------------------------
}
