// ignore_for_file: avoid_catches_without_on_clauses

part of super_fire;

bool checkCanLoop(List<dynamic>? list) {
  bool _canLoop = false;

  if (list != null && list.isNotEmpty) {
    _canLoop = true;
  }

  return _canLoop;
}

Map<String, String>? getStringStringMapFromImmutableMapStringObject(dynamic object){

  Map<String, String>? _output = {};

  if (object != null){

    final String _runTime = object.runtimeType.toString();
    const String _mapType0 = 'ImmutableMap<String, Object?>';
    const String _mapType00 = 'ImmutableMap<String, Object>';
    const String _mapType1 = 'Map<String, Object?>';
    const String _mapType2 = 'Map<String, Object>';
    const String _mapType3 = 'Map<String, dynamic?>';
    const String _mapType4 = 'Map<String, dynamic>';
    const String _mapType5 = '_InternalLinkedHashMap<String, Object?>';
    const String _mapType6 = '_InternalLinkedHashMap<String, Object>';
    const String _mapType7 = '_InternalLinkedHashMap<String, dynamic?>';
    const String _mapType8 = '_InternalLinkedHashMap<String, dynamic>';
    const String _mapType9 = '_InternalLinkedHashMap<String, String>';
    const String _mapType10 = '_InternalLinkedHashMap<String, String?>';

    final bool _canContinue = _runTime == _mapType0 ||
        _runTime == _mapType00 ||
        _runTime == _mapType1 ||
        _runTime == _mapType2 ||
        _runTime == _mapType3 ||
        _runTime == _mapType4 ||
        _runTime == _mapType5 ||
        _runTime == _mapType6 ||
        _runTime == _mapType7 ||
        _runTime == _mapType8 ||
        _runTime == _mapType9 ||
        _runTime == _mapType10;


    if (_canContinue == true){

      final Map _map =  object;
      // blog('3 - FUCK : _map : ${_map.runtimeType}');
      final List<dynamic> _keys = _map.keys.toList();

      if (checkCanLoop(_keys) == true){

        for (final String key in _keys){

          final String _value = _map[key] is String ? _map[key] : _map[key].toString();

          _output = insertPairInMapWithStringValue(
            map: _output,
            key: key,
            value: _value,
            overrideExisting: true,
          );

        }

      }

    }

    else {
      // blog('getStringStringMapFromImmutableMapStringObject : starts : is NOT IMMUTABLE MAP');
    }

  }

  return _output;
}

Map<String, String>? insertPairInMapWithStringValue({
  required Map<String, String>? map,
  required String? key,
  required String value,
  required bool overrideExisting, // otherwise will keep existing pair
}) {

  Map<String, String>? _result = <String, String>{};

  if (map != null){
    _result = map;
  }

  if (key != null){

    /// PAIR IS NULL
    if (_result[key] == null){
      _result[key] = value;
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

void blog(dynamic msg, {String? invoker}){

  assert((){
    if (kDebugMode) {
      debugPrint(msg?.toString());
    }
    return true;
  }(), '_');

}

void blogMap(Map<dynamic, dynamic>? map, {String invoker = ''}) {

  if (map != null){

    blog('$invoker ~~~> <String, dynamic>{');

    final List<dynamic> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    for (int i = 0; i < _keys.length; i++) {

      final String? _index = formatIndexDigits(
        index: i,
        listLength: _keys.length,
      );

      if (_values[i] is Map){
        blog('         $_index. ${_keys[i]} : <${_values[i].runtimeType}>(');
        blogMap(_values[i], invoker: invoker,);
        blog('         ), ');
      }
      else {
        blog('         $_index. ${_keys[i]} : <${_values[i].runtimeType}>( ${_values[i]} ), ');
      }

    }

    blog('      }.........Length : ${_keys.length} keys <~~~');

  }

  else {
    blog('MAP IS NULL : invoker : $invoker');
  }

}

String? formatIndexDigits({
  required int? index,
  required int? listLength,
}){

  return formatIntWithinDigits(
    digits: concludeNumberOfDigits(listLength),
    num: index,
  );

}

String? formatIntWithinDigits({
  required int? num,
  required int? digits,
}) {

  /// this should put the number within number of digits
  /// for digits = 4,, any number should be written like this 0000
  /// 0001 -> 0010 -> 0100 -> 1000 -> 9999
  /// when num = 10000 => should return 'increase digits to view number'

  String? _output;

  if (num != null && digits != null) {

    final int _maxPlusOne = calculateIntegerPower(num: 10, power: digits);
    final int _maxPossibleNum = _maxPlusOne - 1;

    if (num > _maxPossibleNum) {
      _output = 'XXXX';
    }

    else {

      String _numAsText = num.toString();

      for (int i = 1; i <= digits; i++) {

        if (_numAsText.length < digits) {
          _numAsText = '0$_numAsText';
        }

        else {
          break;
        }

      }

      _output = _numAsText;
    }

  }

  return _output;
}

int concludeNumberOfDigits(int? length){
  int _length = 0;

  if (length != null && length != 0){
    _length = modulus(length.toDouble())?.toInt() ?? 0;
    _length = _length.toString().length;
  }

  return _length;
}

double? modulus(double? num){
  double? _val;

  /// NOTE : GETS THE ABSOLUTE VALUE OF A DOUBLE

  if (num != null){
    _val = math.sqrt(calculateDoublePower(num: num, power: 2));
  }

  return _val;
}

double calculateDoublePower({
  required double? num,
  required int? power,
}) {

  /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
  double _output = 1;

  if (num != null && power != null){
    for (int i = 0; i < power; i++) {
      _output *= num;
    }
  }

  return _output;
}

int calculateIntegerPower({
  required int? num,
  required int? power,
}) {

  /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
  int _output = 1;

  if (num != null && power != null) {
    for (int i = 0; i < power; i++) {
      _output *= num;
    }
  }

  return _output;

}

bool checkMapsAreIdentical({
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

void blogMapsDifferences({
  required Map<String, dynamic>? map1,
  required Map<String, dynamic>? map2,
  required String invoker,
}){
  blog('||| $invoker |||||||||||||||||||||||||||||||||||| blogMapsDifferences : START --------o');

  if (map1 == null){
    blog('||| map1 is null');
  }

  if (map2 == null){
    blog('||| map2 is null');
  }

  if (map1 != null && map2 != null){

    final List<String> _keys1 = map1.keys.toList();
    final List<String> _keys2 = map2.keys.toList();

    if (_keys1.length != _keys2.length){
      blog('||| maps lengths are not identical : map1{ ${_keys1.length} keys } : map2{ ${_keys2.length} keys }');
    }

    final List<String> _allKeys = addStringsToStringsIfDoNotContainThem(
      listToTake: _keys1,
      listToAdd: _keys2,
    );

    if (checkCanLoop(_allKeys) == false){
      blog('||| both maps are not null but dead empty');
    }

    else {
      for (final String key in _allKeys){

        final dynamic value2 = map2[key];
        final dynamic value1 = map1[key];

        if (value1 is Map && value2 is Map){
          blogMapsDifferences(
            invoker: '$invoker : $key :-',
            map1: getMapFromIHLMOO(ihlmoo: value1),
            map2: getMapFromIHLMOO(ihlmoo: value2),
          );
        }
        else {
          final bool _identical = value1 == value2;
          final String _identicalArrow = _identical == true ? '' : 'x--->';
          final String _identicalString = _identical == true ? '=' : '!=';
          blog('||| $_identicalArrow   [$key] : [$_identicalString] : 1[$value1] : 2[$value2]');
        }
      }
    }

  }

  blog('||| $invoker |||||||||||||||||||||||||||||||||||| blogMapsDifferences : END --------o');
}

List<String> addStringsToStringsIfDoNotContainThem({
  required List<String>? listToTake,
  required List<String>? listToAdd,
}){

  List<String> _output = <String>[];

  if (checkCanLoop(listToTake) == true){
    _output = listToTake!;
  }

  if (checkCanLoop(listToAdd) == true){

    for (final String string in listToAdd!){

      _output = addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: string
      );

    }

  }

  return _output;
}

List<String> addStringToListIfDoesNotContainIt({
  required List<String>? strings,
  required String? stringToAdd,
}) {

  List<String> _output = <String>[];

  if (checkCanLoop(strings) == true){
    _output = <String>[...strings!];
  }

  if (stringToAdd != null){

    final bool _containsIt = checkStringsContainString(
      strings: _output,
      string: stringToAdd,
    );

    if (_containsIt == false) {
      _output.add(stringToAdd);
    }

  }

  return _output;
}

Map<String, dynamic>? getMapFromIHLMOO({
  required dynamic ihlmoo,
}){
  Map<String, dynamic>? _output;

  /// NOTE : IHLMOO = Internal Hash Linked Map Object Object

  if (ihlmoo != null){
    _output = jsonDecode(jsonEncode(ihlmoo));
    // _output = Map<String, dynamic>.from(internalHashLinkedMapObjectObject);
  }

  return _output;
}

bool checkStringsContainString({
  required List<String?>? strings,
  required String? string,
}) {
  bool _containsIt = false;

  if (checkCanLoop(strings) == true && string != null) {
    _containsIt = strings!.contains(string);
  }

  return _containsIt;
}

Future<void> tryAndCatch({
  required Future<void> Function() functions,
  required String invoker,
  ValueChanged<String>? onError,
  Function? onTimeout,
  int? timeout,
}) async {

  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
          Duration(seconds: timeout),
          onTimeout: () async {

            if (onError != null){
              onError('Timeout ( $invoker ) after ( $timeout) seconds');
            }

            onTimeout?.call();

          });
    }


  }
  // on Exception : this does not work on web
  catch (error) {

    if (onError == null){
      blog('$invoker : tryAndCatch ERROR : $error');
    }

    else {
      onError(error.toString());
    }

    // throw(error);
  }

}

Future<bool> tryCatchAndReturnBool({
  required Future<void> Function() functions,
  ValueChanged<String>? onError,
  int? timeout,
  String invoker = 'tryCatchAndReturnBool',
}) async {
  /// IF FUNCTIONS SUCCEED RETURN TRUE, IF ERROR CAUGHT RETURNS FALSE
  bool _success = false;

  /// TRY FUNCTIONS
  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
      _success = true;
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
          Duration(seconds: timeout),
          onTimeout: () {
            _success = false;
            if (onError != null){
              onError('Timeout ( $invoker ) after ( $timeout) seconds');
            }
          });
    }

  }

  /// CATCH EXCEPTION ERROR
  // on Exception : this does not work on web
  catch (error) {

    blog('$invoker : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    _success = false;
  }

  return _success;
}

bool isEmpty(String? string) {

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

Map<String, dynamic> insertPairInMap({
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

Map<String, dynamic>? cleanNullPairs({
  required Map<String, dynamic>? map,
  bool nullifyEmptyMap = true,
}){
  Map<String, dynamic>? _output;

  if (map != null){

    _output = {};
    final List<String> _keys = map.keys.toList();

    for (final String key in _keys){

      if (map[key] != null){

        if (map[key] is Map<String, dynamic>){
          final Map<String, dynamic>? _sub = cleanNullPairs(
            map: map[key],
            nullifyEmptyMap: nullifyEmptyMap,
          );
          _output = insertPairInMap(
            map: _output,
            key: key,
            value: _sub,
            overrideExisting: true,
          );
        }

        else if (map[key] is List){
          final List _list = map[key];
          final List _updated = [];
          for (final dynamic item in _list){
            if (item is Map){
              final Map<String, dynamic>? _newMap = cleanNullPairs(
                map: item as Map<String, dynamic>,
                nullifyEmptyMap: nullifyEmptyMap,
              );
              _updated.add(_newMap);
            }
            else {
              _updated.add(item);
            }
          }
          _output = insertPairInMap(
            map: _output,
            key: key,
            value: _updated,
            overrideExisting: true,
          );
        }

        else {
          _output = insertPairInMap(
            map: _output,
            key: key,
            value: map[key],
            overrideExisting: true,
          );
        }

      }

      // else {
      //   blog('$key : value is null');
      // }

    }

    if (_output != null && _output.keys.isEmpty == true){
      if (nullifyEmptyMap == true){
        _output = null;
      }
      else {
        _output = <String, dynamic>{};
      }
    }

  }

  // else {
  //   blog('cleanNullPairs: map is null');
  // }

  return _output;
}

Map<String, dynamic>? getMapFromDocumentSnapshot({
  required cloud.DocumentSnapshot<Object>? docSnapshot,
  required bool addDocID,
  required bool addDocSnapshot,
}) {

  Map<String, dynamic>? _map = docSnapshot?.data() as Map<String, dynamic>?;

  if (docSnapshot != null && docSnapshot.exists == true){

    _map ??= {};

    if (addDocID == true) {
      _map['id'] = docSnapshot.id;
    }

    if (addDocSnapshot == true) {
      _map = insertPairInMap(
        map: _map,
        key: 'docSnapshot',
        value: docSnapshot,
        overrideExisting: true,
      );
    }

  }

  return _map;
}

bool checkMapsListsAreIdentical({
  required List<Map<String, dynamic>>? maps1,
  required List<Map<String, dynamic>>? maps2,
}){

  /// OLD BULLSHIT
  // bool _listsAreIdentical = false;
  //
  // if (maps1 == null && maps2 == null){
  //   _listsAreIdentical = true;
  // }
  //
  // else if (maps1?.isEmpty && maps2 == []){
  //   _listsAreIdentical = true;
  // }
  //
  // else if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){
  //
  //   if (maps1.length != maps2.length) {
  //     _listsAreIdentical = false;
  //   }
  //
  //   else {
  //     for (int i = 0; i < maps1.length; i++) {
  //
  //       final bool _mapsAreIdentical = checkMapsAreIdentical(
  //         map1: maps1[i],
  //         map2: maps2[i],
  //       );
  //
  //       if (_mapsAreIdentical == false) {
  //         // blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
  //         _listsAreIdentical = false;
  //         break;
  //       }
  //
  //       else {
  //         _listsAreIdentical = true;
  //       }
  //
  //     }
  //   }
  //
  // }
  //
  // if (_listsAreIdentical == false){
  //   blogMapsListsDifferences(
  //     maps1: maps1,
  //     maps2: maps2,
  //     invoker: 'checkMapsListsAreIdentical',
  //   );
  // }
  // return _listsAreIdentical;

  /// THIS DOES NOT CONDUCT DEEP MAP CHECK
  // return checkListsAreIdentical(list1: maps1, list2: maps2);

  /// ITERATE AND DEEP CHECK
  bool _listsAreIdentical = false;

  if (maps1 == null && maps2 == null){
    _listsAreIdentical = true;
  }
  else if (maps1 != null && maps1.isEmpty == true && maps2 != null && maps2.isEmpty == true){
    _listsAreIdentical = true;
  }

  else if (checkCanLoop(maps1) == true && checkCanLoop(maps2) == true){

    if (maps1!.length != maps2!.length) {
      // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
      // blog(' ---> lis1 is ( ${list1.toString()} )');
      // blog(' ---> lis2 is ( ${list2.toString()} )');
      _listsAreIdentical = false;
    }

    else {
      for (int i = 0; i < maps1.length; i++) {

        if (checkMapsAreIdentical(map1: maps1[i], map2: maps2[i]) == false){
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

String? fixPathFormatting(String? path) {
  /// NOTE : GOOD FORMAT SHOULD BE
  // 'chainK/blah_blah/phid/
  /// => no '/' in the beggining
  /// => there MUST '/' in the end

  String? _output = path?.trim();

  if (isEmpty(_output) == false) {
    /// REMOVE INITIAL SLASH IS EXISTS
    if (_output![0] == '/') {
      _output = removeTextBeforeFirstSpecialCharacter(
        text: _output,
        specialCharacter: '/',
      );
    }

    /// REMOVE LAST '//////' IF EXISTS
    int _lastIndex = _output!.length - 1;
    if (_output[_lastIndex] == '/') {
      _output = removeTextAfterLastSpecialCharacter(
        text: _output,
        specialCharacter: '/',
      );
      _output = '$_output/'; // should always keep one last slash
    }

    /// ASSURE LAST SLASH EXISTS
    _lastIndex = _output.length - 1;
    if (_output[_lastIndex] != '/') {
      _output = '$_output/'; // should always keep one last slash
    }
  }

  return _output;
}

String? removeTextBeforeFirstSpecialCharacter({
  required String? text,
  required String specialCharacter,
}) {
  String? _result;

  if (isEmpty(text) == false){

    _result = text;

    final bool _textContainsChar = stringContainsSubString(
      string: _result,
      subString: specialCharacter,
    );

    if (_textContainsChar == true) {
      final int _position = _result!.indexOf(specialCharacter);
      _result =
      (_position != -1) ? _result.substring(_position + 1, _result.length)
          :
      _result;
    }

  }

  return _result;
}

bool stringContainsSubString({
  required String? string,
  required String? subString,
}) {
  bool _itContainsIt = false;

  if (string != null && subString != null) {
    if (string.toLowerCase().contains(subString.toLowerCase()) == true) {
      _itContainsIt = true;
    }
  }

  return _itContainsIt;
}

String? removeTextAfterLastSpecialCharacter({
  required String? text,
  required String specialCharacter,
}) {
  String? _result;

  if (isEmpty(text) == false){

    _result = text;

    final bool _textContainsChar = stringContainsSubString(
      string: text,
      subString: specialCharacter,
    );

    if (_textContainsChar == true) {
      _result = text?.substring(0, text.lastIndexOf(specialCharacter));
    }

  }
  else {
    _result = text;
  }

  return _result;
}

Map<String, dynamic> insertMapInMap({
  required Map<String, dynamic>? baseMap,
  required Map<String, dynamic>? insert,
  bool replaceDuplicateKeys = true,
  bool cleanByDecoding = true,
}){
  Map<String, dynamic>? _output = baseMap;

  if (cleanByDecoding == true){
    _output = cloneMap(baseMap);
  }

  if (insert != null){

    final List<String> _keys = insert.keys.toList();

    if (checkCanLoop(_keys) == true){

      for (final String key in _keys){

        _output = insertPairInMap(
          map: _output,
          key: key,
          value: insert[key],
          overrideExisting: replaceDuplicateKeys,
        );

      }

    }

  }

  return _output ?? {};
}

Map<String, dynamic>? cloneMap(Map<String, dynamic>? map){
  if (map == null){
    return null;
  }
  else {
    return jsonDecode(jsonEncode(map));
  }
}

List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
  required List<cloud.QueryDocumentSnapshot<Object>>? queryDocumentSnapshots,
  required bool addDocsIDs,
  required bool addDocSnapshotToEachMap,
}) {

  final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  if (checkCanLoop(queryDocumentSnapshots) == true) {

    for (final cloud.QueryDocumentSnapshot<Object> docSnapshot in queryDocumentSnapshots!) {

      Map<String, dynamic>? _map = docSnapshot.data() as Map<String, dynamic>?;

      if (_map != null){
        if (addDocsIDs == true) {
          _map['id'] = docSnapshot.id;
        }

        if (addDocSnapshotToEachMap == true) {
          _map = insertPairInMap(
            map: _map,
            key: 'docSnapshot',
            value: docSnapshot,
            overrideExisting: true,
          );
        }

        _maps.add(_map);
      }

    }

  }

  return _maps;
}

List<Map<String, dynamic>> mapSnapshots(cloud.QuerySnapshot<Map<String, dynamic>> querySnapshot){

  final List<Map<String, dynamic>> _maps = getMapsFromQuerySnapshot(
    querySnapshot: querySnapshot,
    addDocsIDs: true,
    addDocSnapshotToEachMap: true,
  );

  return _maps;
}

List<Map<String, dynamic>> getMapsFromQuerySnapshot({
  required cloud.QuerySnapshot<Object> querySnapshot,
  required bool addDocsIDs,
  required bool addDocSnapshotToEachMap,
}) {

  return getMapsFromQueryDocumentSnapshotsList(
    queryDocumentSnapshots: querySnapshot.docs,
    addDocsIDs: addDocsIDs,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
  );
}

Map<String, dynamic>? mapSnapshot(cloud.DocumentSnapshot<Object>? docSnapshot){

  final Map<String, dynamic>? _map = getMapFromDocumentSnapshot(
    docSnapshot: docSnapshot,
    addDocID: true,
    addDocSnapshot: true,
  );

  return _map;
}

List<String> getMapsPrimaryKeysValues({
  required List<Map<String, dynamic>>? maps,
  String primaryKey = 'id',
  bool throwErrorOnInvalidID = false,
}){

  final List<String> _primaryKeys = <String>[];

  if (checkCanLoop(maps) == true){

    for (final Map<String, dynamic> map in maps!){

      final dynamic _id = map[primaryKey];

      if (_id != null && _id is String){
        _primaryKeys.add(_id);
      }
      else {
        if (throwErrorOnInvalidID == true){
          // assert(_id is String, 'id : $_id is not a String');
          final Error _error = ArgumentError('id : $_id is not a String');
          throw _error;
        }
      }

    }

  }

  return _primaryKeys;
}

Map<String, dynamic> removePair({
  required Map<String, dynamic>? map,
  required String? fieldKey,
}) {
  Map<String, dynamic> _output = {};
  _output = insertMapInMap(
    baseMap: _output,
    insert: map,
  );

  if (map != null && fieldKey != null){
    _output.removeWhere((key, value) => key == fieldKey);
  }

  return _output;
}

List<Map<String, dynamic>>? getMapsFromDataSnapshot({
  required f_db.DataSnapshot? snapshot,
  required bool addDocID,
}) {
  // List<Map<String, dynamic>> _output;
  //
  // if (snapshot.exists) {
  //
  //   // blog('snapshot type : ${snapshot.value.runtimeType}');
  //
  //   // if (snapshot.value.runtimeType.toString() == 'List<Object?>'){
  //
  //     _output = [];
  //
  //     final List<dynamic> _dynamics = snapshot.children.toList();
  //
  //     for (final dynamic object in _dynamics){
  //
  //       final Map<String, dynamic> _maw = getMapFromDataSnapshot(
  //         snapshot: object,
  //         addDocID: addDocID,
  //       );
  //
  //       _output.add(_maw);
  //
  //     }
  //
  //   // }
  //
  //   // if (snapshot.value.runtimeType.toString() == '_InternalLinkedHashMap<Object?, Object?>'){
  //   //
  //   //   final Map<String, dynamic> _map = getMapFromInternalHashLinkedMapObjectObject(
  //   //     internalHashLinkedMapObjectObject: snapshot.value,
  //   //   );
  //   //
  //   //   Mapper.blogMap(_map, invoker: 'the fookin maw');
  //   //
  //   //   _output = [];
  //   //   if (_map != null){
  //   //     _output.add(_map);
  //   //   }
  //   //
  //   // }
  //
  //
  // }
  //
  // return _output;

  final List<Map<String, dynamic>> _output = [];

  if (snapshot != null && snapshot.value != null) {

    final Map<String, dynamic>? _bigMap = getMapFromDataSnapshot(
      snapshot: snapshot,
      addDocID: false,
    );
    final List<String>? _keys = _bigMap?.keys.toList();

    // blog('snapshot.value : ${snapshot.value} : type : ${snapshot.value.runtimeType}');


    if (_bigMap != null && checkCanLoop(_keys) == true){

      for (final String key in _keys!) {

        /// CHILD IS MAP
        if (_bigMap[key] is Map<String, dynamic> || _bigMap[key] is Map<Object, Object>) {
          /// ADD ONLY THE ID OF EACH MAP, BUT IF THE MAP CONTAINS
          /// SUB MAPS, ADDING THEIRS IDS IS IGNORED,
          final Map<String, dynamic> _map = insertPairInMap(
            map: _bigMap[key],
            key: 'id',
            value: key,
            overrideExisting: true,
          );

          _output.add(_map);
        }

        /// CHILD IS NOT A MAP
        else {
          final Map<String, dynamic> _map = {
            key: _bigMap[key],
          };

          _output.add(_map);
        }

      }

    }

  }

  return _output;

}

Map<String, dynamic>? getMapFromDataSnapshot({
  required f_db.DataSnapshot? snapshot,
  required bool addDocID,
  Function? onExists,
  Function? onNull,
}){
  Map<String, dynamic>? _output;

  if (snapshot != null && snapshot.exists == true && snapshot.key != null) {

    // blog('snapshot.value : ${snapshot.value} : type : ${snapshot.value.runtimeType}');

    if (snapshot.value.runtimeType.toString() == '_InternalLinkedHashMap<Object?, Object?>'){
      _output = getMapFromIHLMOO(
        ihlmoo: snapshot.value,
      );
    }
    else if (snapshot.value.runtimeType.toString() == '_Map<Object?, Object?>'){
      _output = getMapFromIHLMOO(
        ihlmoo: snapshot.value,
      );
    }
    else if (snapshot.value.runtimeType.toString() == 'IdentityMap<String, dynamic>'){
      _output = getMapFromIHLMOO(
        ihlmoo: snapshot.value,
      );
    }
    else if (objectIsMinified(snapshot.value) == true){
      _output = getMapFromIHLMOO(
        ihlmoo: snapshot.value,
      );
    }
    else  {
      _output = {
        snapshot.key! : snapshot.value,
      };
    }
    // else {
    //   _output = Map<String, dynamic>.from(snapshot.value);
    // }


    if (addDocID == true){
      _output = insertPairInMap(
        map: _output,
        key: 'id',
        value: snapshot.key,
        overrideExisting: true,
      );
    }

    if (onExists != null){
      onExists();
    }
  }

  else {
    if (onNull != null){
      onNull();
    }
  }

  return _output;
}

bool objectIsMinified(dynamic object){
  bool _isMinified = false;

  if (object != null){

    _isMinified = stringStartsExactlyWith(
      text: object.runtimeType.toString(),
      startsWith: 'minified',
    );

  }

  return _isMinified;
}

bool stringStartsExactlyWith({
  required String? text,
  required String? startsWith, // http
}){
  bool _output = false;

  if (isEmpty(text) == false && isEmpty(startsWith) == false){

    final String? _cutText = removeAllCharactersAfterNumberOfCharacters(
      text: text,
      numberOfChars: startsWith!.length,
    );

    if (_cutText == startsWith){
      _output = true;
    }

  }

  return _output;
}

String? removeAllCharactersAfterNumberOfCharacters({
  required String? text,
  required int? numberOfChars,
}) {
  String? _output = text;

  if (text != null &&
      numberOfChars != null &&
      text.isNotEmpty &&
      text.length > numberOfChars
  ) {
    _output = text.substring(0, numberOfChars);
  }

  return _output;
}

String? removeTextBeforeLastSpecialCharacter({
  required String? text,
  required String specialCharacter,
}) {
  String? _result = text;

  if (isEmpty(text) == false){

    final bool _textContainsChar = stringContainsSubString(
      string: text,
      subString: specialCharacter,
    );

    if (_textContainsChar == true) {

      final int _position = _result!.lastIndexOf(specialCharacter);

      _result = text == null ? null
          :
      (_position != -1) ? text.substring(_position + 1, text.length)
          :
      text;
    }

  }

  return _result;
}

Map<String, dynamic>? createPathValueMapFromIncrementationMap({
  required Map<String, int>? incrementationMap,
  required bool isIncrementing,
}){

  /*
    /// INCREMENTATION MAP LOOK LIKE THIS
    final Map<String, int> _incrementationMap = {
      'key1': 1,
      'key2': 2,
    };
     */

  Map<String, dynamic> _output = {};

  final List<String>? _keys = incrementationMap?.keys.toList();

  if (incrementationMap != null && checkCanLoop(_keys) == true){

    for (final String key in _keys!){

      int? _incrementationValue = incrementationMap[key];

      if (_incrementationValue != null && isIncrementing == false){
        _incrementationValue = -_incrementationValue;
      }

      if (_incrementationValue != null){
        _output = insertPairInMap(
          map: _output,
          key: key,
          value: f_db.ServerValue.increment(_incrementationValue),
          overrideExisting: true,
        );
      }

    }

  }

  return _output;
}

