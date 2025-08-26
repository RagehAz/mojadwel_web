part of super_fire;

enum FireComparison {
  ///
  greaterThan,
  ///
  greaterOrEqualThan,
  ///
  lessThan,
  ///
  lessOrEqualThan,
  /// WHEN : dynamic x on db == (x);
  equalTo,
  ///
  notEqualTo,
  /// WHEN : dynamic x on db is null == (true)
  nullValue,
  ///
  whereIn,
  ///
  whereNotIn,
  /// WHEN : List<dynamic>['a', 'b', 'c'] on db contains ('b') or not.
  arrayContains,
  ///
  arrayContainsAny,
}

class QueryOrderBy {
  /// --------------------------------------------------------------------------
  const QueryOrderBy({
    required this.fieldName,
    required this.descending,
  });
  /// --------------------------------------------------------------------------
  final String fieldName;
  final bool descending;
/// --------------------------------------------------------------------------
}

/// => TAMAM
@immutable
class FireQueryModel {
  /// --------------------------------------------------------------------------
  const FireQueryModel({
    required this.coll,
    this.doc,
    this.subColl,
    this.idFieldName ='id',
    this.limit,
    this.orderBy,
    this.finders,
    this.initialMaps,
  });
  /// --------------------------------------------------------------------------
  final String coll;
  final String? doc;
  final String? subColl;
  final int? limit;
  final QueryOrderBy? orderBy;
  final List<FireFinder>? finders;
  final List<Map<String, dynamic>>? initialMaps;
  final String idFieldName;
  // -----------------------------------------------------------------------------

  /// QueryParameter CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  FireQueryModel copyWith({
    String? coll,
    String? doc,
    String? subColl,
    String? idFieldName,
    int? limit,
    QueryOrderBy? orderBy,
    List<FireFinder>? finders,
    List<Map<String, dynamic>>? initialMaps,
  }){
    return FireQueryModel(
      coll: coll ?? this.coll,
      doc: doc ?? this.doc,
      subColl: subColl ?? this.subColl,
      idFieldName: idFieldName ?? this.idFieldName,
      limit: limit ?? this.limit,
      orderBy: orderBy ?? this.orderBy,
      finders: finders ?? this.finders,
      initialMaps: initialMaps ?? this.initialMaps,
    );
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkQueriesAreIdentical({
    required FireQueryModel? model1,
    required FireQueryModel? model2,
  }){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }

    else if (model1 != null && model2 != null){

      if (
      model1.coll == model2.coll &&
          model1.doc == model2.doc &&
          model1.subColl == model2.subColl &&
          model1.idFieldName == model2.idFieldName &&
          model1.limit == model2.limit &&
          model1.orderBy?.descending == model2.orderBy?.descending &&
          model1.orderBy?.fieldName == model2.orderBy?.fieldName &&
          FireFinder.checkFindersListsAreIdentical(model1.finders, model2.finders) == true &&
          checkMapsListsAreIdentical(maps1: model1.initialMaps, maps2: model2.initialMaps) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FireQueryModel){
      _areIdentical = checkQueriesAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      coll.hashCode^
      doc.hashCode^
      subColl.hashCode^
      idFieldName.hashCode^
      limit.hashCode^
      orderBy.hashCode^
      finders.hashCode^
      initialMaps.hashCode;
// -----------------------------------------------------------------------------
}

@immutable
class FireFinder {
  /// --------------------------------------------------------------------------
  const FireFinder({
    required this.field,
    required this.comparison,
    required this.value,
  });
  /// --------------------------------------------------------------------------
  final String field; /// fire field name
  final FireComparison comparison; /// fire equality comparison type
  final dynamic value; /// search value
  // -----------------------------------------------------------------------------

  /// NATIVE QUERY CREATOR


  // -----------------------------------------------------------------------------

  /// QUERY CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFindersAreIdentical(FireFinder? finder1, FireFinder? finder2){
    bool _identical = false;

    if (finder1 == null && finder2 == null){
      _identical = true;
    }

    else if (finder1 != null && finder2 != null){

      if (
      finder1.field == finder2.field &&
          finder1.comparison == finder2.comparison &&
          finder1.value == finder2.value
      ){
        _identical = true;
      }

    }

    return _identical;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFindersListsAreIdentical(List<FireFinder>? finders1, List<FireFinder>? finders2){
    bool _output = false;

    if (finders1 == null && finders2 == null){
      _output = true;
    }
    else if (finders1 != null && finders1.isEmpty && finders2 != null && finders2.isEmpty){
      _output = true;
    }
    else if (finders1 != null && finders2 != null){

      if (finders1.length != finders2.length){
        _output = false;
      }

      else {

        for (int i = 0; i < finders1.length; i++){

          final bool _areIdentical = checkFindersAreIdentical(
            finders1[i],
            finders2[i],
          );

          if (_areIdentical == false){
            _output = false;
            break;
          }

          else {
            _output = true;
          }

        }

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() => 'FireFinder(field: $field, comparison: $comparison, value: $value)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FireFinder){
      _areIdentical = checkFindersAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      field.hashCode^
      comparison.hashCode^
      value.hashCode;
// -----------------------------------------------------------------------------
}

enum RealOrderType {
  byChild,
  byValue,
  byPriority,
  byKey,
}

enum QueryRange {
  startAfter,
  endAt,
  startAt,
  endBefore,
  equalTo,
}

@immutable
class RealQueryModel{
  // -----------------------------------------------------------------------------
  const RealQueryModel({
    required this.path,
    this.idFieldName,
    this.limit = 5,
    this.readFromBeginningOfOrderedList = true,
    this.orderType,
    this.fieldNameToOrderBy,
    this.queryRange,
  });
  // -----------------------------------------------------------------------------
  final String path;
  final int? limit;
  final String? idFieldName;
  final bool readFromBeginningOfOrderedList;
  final RealOrderType? orderType;
  final String? fieldNameToOrderBy;
  final QueryRange? queryRange;
  // -----------------------------------------------------------------------------

  /// ASCENDING QUERY

  // --------------------
  /// TESTED : WORKS PERFECT
  static RealQueryModel createAscendingQueryModel({
    required String path,
    required String idFieldName,
    String? fieldNameToOrderBy,
    int limit = 5,
  }){
    return RealQueryModel(
      path: path,
      limit: limit,
      idFieldName: idFieldName, /// should be docID : 'id'
      fieldNameToOrderBy: fieldNameToOrderBy,
      orderType: RealOrderType.byChild,
      queryRange: QueryRange.startAfter,
      // readFromBeginningOfOrderedList: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// REAL PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createRealPath({
    required String coll,
    String? doc,
    String? key, // what is this ? sub node / doc field
  }){

    String _path = coll;

    if (doc != null){

      _path = '$_path/$doc';

      if (key != null){
        _path = '$_path/$key';
      }

    }

    return fixPathFormatting(_path)!;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogModel(){
    blog('RealQueryModel ------------------------> START');
    blog('path               : $path');
    blog('keyField           : $idFieldName');
    blog('fieldNameToOrderBy : $fieldNameToOrderBy');
    blog('orderType          : $orderType');
    blog('range              : $queryRange');
    blog('limitToFirst       : $readFromBeginningOfOrderedList');
    blog('limit              : $limit');
    blog('RealQueryModel ------------------------> END');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkQueriesAreIdentical({
    required RealQueryModel? model1,
    required RealQueryModel? model2,
  }){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }

    else if (model1 != null && model2 != null){

      if (
      model1.path == model2.path &&
          model1.limit == model2.limit &&
          model1.idFieldName == model2.idFieldName &&
          model1.readFromBeginningOfOrderedList == model2.readFromBeginningOfOrderedList &&
          model1.orderType == model2.orderType &&
          model1.fieldNameToOrderBy == model2.fieldNameToOrderBy &&
          model1.queryRange == model2.queryRange
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is RealQueryModel){
      _areIdentical = checkQueriesAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      path.hashCode^
      idFieldName.hashCode^
      limit.hashCode^
      readFromBeginningOfOrderedList.hashCode^
      orderType.hashCode^
      fieldNameToOrderBy.hashCode^
      queryRange.hashCode;
// -----------------------------------------------------------------------------

}
