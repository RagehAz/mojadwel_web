import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';
import '../../core/shared_components/super_text/super_text.dart';
import 'components/test_button.dart';

class FireTestingScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const FireTestingScreen({super.key});

  @override
  State<FireTestingScreen> createState() => _FireTestingScreenState();
}

class _FireTestingScreenState extends State<FireTestingScreen> {
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

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

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
  final String _coll = 'testColl';
  final String _doc = 'testDoc';
  final Map<String, dynamic> _docMap = {
    'id' : 'testDoc',
    'value1' : 'value1',
    'value2' : 2,
    'value3' : {
      'subq' : 'subValue',
      'sub2' : 'subValue2',
    },
  };
  final Map<String, dynamic> _updatedDocMap = {
    'id' : 'testDoc',
    'value1' : 'value1',
    'value2' : 2,
    'value3' : {
      'subq' : 'subValue',
      'sub2' : 'subValue2',
    },
    'someNewValue' : 'someNewValue',
  };
  final String _newDocField = 'newField';
  final String _newDocValue = 'the new value for the field';
  // --------------------
  final String _subColl = 'testSubColl';
  final String _subDoc = 'testSubDoc';
  final Map<String, dynamic> _subDocMap = {
    'id' : 'testSubDoc',
    'value' : 'bojo',
  };
  final Map<String, dynamic> _updatedSubDocMap = {
    'id' : 'testSubDoc',
    'value' : 'bojo',
    'someNewValue' : 'someNewValue',
    'someNewValue2' : 'someNewValue2',
  };
  // --------------------
  final List<Map<String, dynamic>> _multipleMaps = [

    {
      'id' : 'testDoc1',
      'value1' : 'bobo',
    },
    {
      'id' : 'testDoc2',
      'value1' : 'koko',
    },
    {
      'id' : 'testDoc3',
      'value1' : 'momo',
    },
    {
      'id' : 'testDoc4',
      'value1' : 'toto',
    },
    {
      'id' : 'testDoc5',
      'value1' : 'gogo',
    },
    {
      'id' : 'testDoc6',
      'value1' : 'fofo',
    },

  ];
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TheLayout(
      child: (ScreenDim screen) => VerticalFloatingList(
        children: [

          /// OfficialEmailAuthing.signIn
          TestButton(
            text: 'EmailAuthing signIn as rageh',
            function: () => OfficialGoogleAuthing.googleAuth(),
            result: (dynamic result) {
              if (result != null){
                setState(() {});
              }
              return  result != null;
            },
          ),

          // =======>

          if (OfficialAuthing.userHasID() == true)
            Column(
              children: <Widget>[

                /// DOC TESTS
                const SuperHeadline(text: 'NAMED Doc tests'),

                /// 1. OfficialFire.createDoc
                TestButton(
                  text: '1. Fire createDoc',
                  function: () => OfficialFire.createDoc(
                    coll: _coll,
                    doc: _doc,
                    input: _docMap,
                  ),
                  result: (dynamic result) => result == _doc,
                ),

                /// 2. OfficialFire.readDoc
                TestButton(
                  text: '2. Fire readDoc',
                  function: () => OfficialFire.readDoc(
                    coll: _coll,
                    doc: _doc,
                  ),
                  result: (dynamic result) => Helpers.checkMapsAreIdentical(map1: result, map2: _docMap),
                ),

                /// 3. OfficialFire.updateDoc
                TestButton(
                  text: '3. Fire updateDoc',
                  addNotes: const [
                    'This test will update the doc, then reads it and compares it with the created doc',
                  ],
                  function: () => OfficialFire.updateDoc(coll: _coll, doc: _doc, input: _updatedDocMap),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                    );

                    final bool _identical = Helpers.checkMapsAreIdentical(
                      map1: _updated,
                      map2: _updatedDocMap,
                    );

                    return _identical;
                  },
                ),

                /// 4. OfficialFire.updateDocField
                TestButton(
                  text: '4. Fire updateDocField',
                  addNotes: const [
                    'For this to succeed, the doc should be updated first by the previous test',
                    'This test will update the doc FIELD, then reads it and compares it with the UPDATED doc after manually adding the new field to the original updated doc',
                  ],
                  function: () => OfficialFire.updateDocField(
                    coll: _coll,
                    doc: _doc,
                    field: _newDocField,
                    input: _newDocValue,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                    );

                    final Map<String, dynamic> _mapWithNewField = Helpers.insertPairInMap(
                      map: _updatedDocMap,
                      key: _newDocField,
                      value: _newDocValue,
                      overrideExisting: true,
                    );

                    final bool _identical = Helpers.checkMapsAreIdentical(
                      map1: _updated,
                      map2: _mapWithNewField,
                    );

                    return _identical;
                  },
                ),

                /// 5. OfficialFire.deleteDocField
                TestButton(
                  text: '5. Fire deleteDocField',
                  addNotes: const [
                    'For this to succeed, the doc should be updated doc then update field',
                    'This test will delete the doc FIELD, then reads the the doc and compares it with original updated doc',
                  ],
                  function: () => OfficialFire.deleteDocField(
                    coll: _coll,
                    doc: _doc,
                    field: _newDocField,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                    );

                    final bool _identical = Helpers.checkMapsAreIdentical(
                      map1: _updated,
                      map2: _updatedDocMap,
                    );

                    return _identical;
                  },
                ),

                /// 6. OfficialFire.deleteDoc
                TestButton(
                  text: '6. Fire deleteDoc',
                  function: () => OfficialFire.deleteDoc(
                    coll: _coll,
                    doc: _doc,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                    );

                    return _updated == null;
                  },
                ),

                // =======>

                /// SUB DOC TESTS
                const SuperHeadline(text: 'SubDoc tests'),

                /// 7. OfficialFire.createDoc (SUB DOC)
                TestButton(
                  text: '7. Fire createDoc ( SUB DOC )',
                  function: () => OfficialFire.createDoc(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                    subDoc: _subDoc,
                    input: _subDocMap,
                  ),
                  result: (dynamic result) => result == _subDoc,
                ),

                /// 8. OfficialFire.readDoc (SUB DOC)
                TestButton(
                  text: '8. Fire readDoc ( SUB DOC )',
                  function: () => OfficialFire.readDoc(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                    subDoc: _subDoc,
                  ),
                  result: (dynamic result) => Helpers.checkMapsAreIdentical(map1: result, map2: _subDocMap),
                ),

                /// 9. OfficialFire.updateDoc (SUB DOC)
                TestButton(
                  text: '9. Fire updateDoc ( SUB DOC )',
                  addNotes: const [
                    'This test will update the doc, then reads it and compares it with the created doc',
                  ],
                  function: () => OfficialFire.updateDoc(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                    subDoc: _subDoc,
                    input: _updatedSubDocMap,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                      subColl: _subColl,
                      subDoc: _subDoc,
                    );

                    final bool _identical = Helpers.checkMapsAreIdentical(
                      map1: _updated,
                      map2: _updatedSubDocMap,
                    );

                    return _identical;
                  },
                ),

                /// 10. OfficialFire.updateDocField (SUB DOC)
                TestButton(
                  text: '10. Fire updateDocField (SUB DOC)',
                  addNotes: const [
                    'For this to succeed, the doc should be updated first by the previous test',
                    'This test will update the doc FIELD, then reads it and compares it with the UPDATED doc after manually adding the new field to the original updated doc',
                  ],
                  function: () => OfficialFire.updateDocField(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                    subDoc: _subDoc,
                    field: _newDocField,
                    input: _newDocValue,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                      subColl: _subColl,
                      subDoc: _subDoc,
                    );

                    final Map<String, dynamic> _mapWithNewField = Helpers.insertPairInMap(
                      map: _updatedSubDocMap,
                      key: _newDocField,
                      value: _newDocValue,
                      overrideExisting: true,
                    );

                    final bool _identical = Helpers.checkMapsAreIdentical(
                      map1: _updated,
                      map2: _mapWithNewField,
                    );

                    return _identical;
                  },
                ),

                /// 11. OfficialFire.deleteDocField (SUB DOC)
                TestButton(
                  text: '11. Fire deleteDocField (SUB DOC)',
                  addNotes: const [
                    'For this to succeed, the doc should be updated doc then update field',
                    'This test will delete the doc FIELD, then reads the the doc and compares it with original updated doc',
                  ],
                  function: () => OfficialFire.deleteDocField(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                    subDoc: _subDoc,
                    field: _newDocField,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                      subColl: _subColl,
                      subDoc: _subDoc,
                    );

                    final bool _identical = Helpers.checkMapsAreIdentical(
                      map1: _updated,
                      map2: _updatedSubDocMap,
                    );

                    return _identical;
                  },
                ),

                /// 12. OfficialFire.deleteDoc (SUB DOC)
                TestButton(
                  text: '12. Fire deleteDoc (SUB DOC)',
                  function: () => OfficialFire.deleteDoc(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                    subDoc: _subDoc,
                  ),
                  result: (dynamic result) async {
                    final Map<String, dynamic>? _updated = await OfficialFire.readDoc(
                      coll: _coll,
                      doc: _doc,
                      subColl: _subColl,
                      subDoc: _subDoc,
                    );

                    return _updated == null;
                  },
                ),

                // =======>

                /// DOC TESTS
                const SuperHeadline(text: 'un - NAMED Doc tests'),

                /// 13. OfficialFire.createDoc (multiple docs)
                TestButton(
                  text: '13. Fire createDoc ( un-named )',
                  function: () => OfficialFire.createDoc(coll: _coll, input: {
                    'blah': 'this should work',
                  }),
                  result: (dynamic result) async {
                    return result != null;
                  },
                ),

                // =======>

                const SuperHeadline(text: 'Coll tests'),


                /// 14. OfficialFire.createDoc (multiple docs)
                TestButton(
                  text: '14. Fire createDoc ( CREATE MULTIPLE DOCS )',
                  function: () => OfficialFire.createDocs(
                    inputs: _multipleMaps,
                    coll: _coll,
                  ),
                  result: (dynamic result) async {
                    final List<String>? _ids = result;

                    return _ids != null && _ids.length == _multipleMaps.length;
                  },
                ),

                /// 15. OfficialFire.readColl (only 2 docs)
                TestButton(
                  text: '15. Fire readColl (only 2 docs)',
                  function: () => OfficialFire.readColl(
                    queryModel: FireQueryModel(
                      coll: _coll,
                      limit: 2,
                    ),
                  ),
                  result: (dynamic result) async {
                    final List<Map<String, dynamic>>? _maps = result;

                    Helpers.blogMaps(_maps);

                    return _maps != null && _maps.length == 2;
                  },
                ),

                /// 16. OfficialFire.readAllColl
                TestButton(
                  text: '16. Fire readAllColl',
                  function: () => OfficialFire.readAllColl(
                    coll: _coll,
                  ),
                  result: (dynamic result) async {
                    final List<Map<String, dynamic>>? _maps = result;

                    Helpers.blogMaps(_maps);

                    return _maps != null && _maps.isNotEmpty;
                  },
                ),

                /// 17. OfficialFire.deleteDocs (only 2 docs)
                TestButton(
                  text: '17. Fire deleteDocs',
                  function: () async {

                    final List<String> _ids = await OfficialFire.createDocs(
                      coll: _coll,
                      inputs: [
                        {'blah': 'this should work'},
                        {'blah2': 'this should work'},
                      ],
                    );

                    Helpers.blogStrings(strings: _ids, invoker: 'deleteDocs. the ids are');

                    final List<Map<String, dynamic>>? _maps = await OfficialFire.readCollDocs(
                      coll: _coll,
                      ids: _ids,
                    );

                    Helpers.blogMaps(_maps);

                    if (_maps != null && _maps.length == 2) {
                      await OfficialFire.deleteDocs(
                        coll: _coll,
                        docsIDs: _ids,
                      );

                      final List<Map<String, dynamic>>? _maps = await OfficialFire.readCollDocs(
                        coll: _coll,
                        ids: _ids,
                      );

                      blog('final maps should be empty and they are $_maps');

                      if (_maps != null && _maps.isEmpty) {
                        return true;
                      } else {
                        return false;
                      }
                    } else {
                      return false;
                    }
                  },
                  result: (dynamic result) async {
                    return result;
                  },
                ),

                /// 18. OfficialFire.deleteColl
                TestButton(
                  text: '18. Fire deleteColl',
                  function: () => OfficialFire.deleteColl(
                    coll: _coll,
                    numberOfIterations: 10,
                    numberOfReadsPerIteration: 2,
                  ),
                  result: (dynamic result) async {
                    final List<Map<String, dynamic>> _maps = await OfficialFire.readAllColl(
                      coll: _coll,
                    );

                    return _maps.isEmpty;
                  },
                ),

                // =======>

                const SuperHeadline(text: ' SUB Coll tests'),

                /// 19. OfficialFire.createDoc (multiple docs)
                TestButton(
                  text: '19. Fire createDoc ( CREATE MULTIPLE SUB DOCS )',
                  function: () => OfficialFire.createDocs(
                    inputs: _multipleMaps,
                    coll: _coll,
                    subColl: _subColl,
                    doc: _doc,
                  ),
                  result: (dynamic result) async {
                    final List<String>? _ids = result;

                    return _ids != null && _ids.length == _multipleMaps.length;
                  },
                ),

                /// 20. OfficialFire.readColl (only 2 docs)
                TestButton(
                  text: '20. Fire readColl (only 2 SUB docs)',
                  function: () => OfficialFire.readColl(
                    queryModel: FireQueryModel(
                      coll: _coll,
                      subColl: _subColl,
                      doc: _doc,
                      limit: 2,
                    ),
                  ),
                  result: (dynamic result) async {
                    final List<Map<String, dynamic>>? _maps = result;

                    Helpers.blogMaps(_maps);

                    return _maps != null && _maps.length == 2;
                  },
                ),

                /// 21. OfficialFire.readAllColl
                TestButton(
                  text: '21. Fire readAllColl (SUB COLL)',
                  function: () => OfficialFire.readAllColl(
                    coll: _coll,
                    doc: _doc,
                    subColl: _subColl,
                  ),
                  result: (dynamic result) async {
                    final List<Map<String, dynamic>>? _maps = result;

                    Helpers.blogMaps(_maps);

                    return _maps != null && _maps.isNotEmpty;
                  },
                ),

                /// 22. OfficialFire.deleteDocs (only 2 docs)
                TestButton(
                  text: '22. Fire deleteDocs (SUB DOCS)',
                  function: () async {

                    final List<String> _ids = await OfficialFire.createDocs(
                      coll: _coll,
                      doc: _doc,
                      subColl: _subColl,
                      inputs: [
                        {'blah': 'this should work'},
                        {'blah2': 'this should work'},
                      ],
                    );

                    final List<Map<String, dynamic>>? _maps = await OfficialFire.readCollDocs(
                      coll: _coll,
                      doc: _doc,
                      subColl: _subColl,
                      ids: _ids,
                    );

                    Helpers.blogMaps(_maps);

                    if (_maps != null && _maps.length == 2) {
                      await OfficialFire.deleteDocs(
                        coll: _coll,
                        subColl: _subColl,
                        doc: _doc,
                        docsIDs: _ids,
                      );

                      final List<Map<String, dynamic>>? _maps = await OfficialFire.readCollDocs(
                        coll: _coll,
                        subColl: _subColl,
                        doc: _doc,
                        ids: _ids,
                      );

                      blog('final maps should be empty and they are $_maps');

                      if (_maps != null && _maps.isEmpty) {
                        return true;
                      } else {
                        return false;
                      }
                    } else {
                      return false;
                    }
                  },
                  result: (dynamic result) async {
                    return result;
                  },
                ),

                /// 23. OfficialFire.deleteColl
                TestButton(
                  text: '23. Fire deleteColl (SUB COLL)',
                  function: () => OfficialFire.deleteColl(
                    coll: _coll,
                    subColl: _subColl,
                    doc: _doc,
                    numberOfIterations: 10,
                    numberOfReadsPerIteration: 2,
                  ),
                  result: (dynamic result) async {

                    final List<Map<String, dynamic>> _maps = await OfficialFire.readAllColl(
                      coll: _coll,
                      subColl: _subColl,
                      doc: _doc,
                    );

                    return _maps.isEmpty;
                  },
                ),


              ],
            ),
        ],
      )
    );

  }
// -----------------------------------------------------------------------------
}

class Helpers {
  // --------------------
  /// AI TESTED
  static bool checkMapsAreIdentical({
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
  static Map<String, dynamic> insertPairInMap({
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
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static void blogMaps(List<Map<String, dynamic>>? maps, {String invoker = 'map'}) {
    if (checkCanLoop(maps) == true) {
      for (int i = 0; i < maps!.length; i++) {
        final Map<String, dynamic> map = maps[i];
        blogMap(map,
          invoker: '$i : $invoker',
        );
      }
    }

    else {
      blog('No maps to blog ( $invoker )');
    }
  }
  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogStrings({
    required List<String?>? strings,
    required String? invoker,
  }){
    blog('blogStrings : START --- : $invoker');
    if (checkCanLoop(strings) == true){


      for (int i = 0; i <strings!.length; i++){

        final String? _index = formatIndexDigits(
            index: i,
            listLength: strings.length
        );


        blog('$_index : [ ${strings[i]} ]');

      }

    }
    else {

      if (strings == null){
        blog('blogStrings : list is null');
      }
      else if (strings.isEmpty == true){
        blog('blogStrings : list is empty');
      }
      else {
        blog('blogStrings : list is weird');
      }

    }

    blog('blogStrings : END --- : $invoker');

  }
  // --------------------
  /// AI TESTED
  static String? formatIndexDigits({
    required int? index,
    required int? listLength,
  }){

    return formatIntWithinDigits(
      digits: concludeNumberOfDigits(listLength),
      num: index,
    );

  }
  // --------------------
  /// AI TESTED
  static int concludeNumberOfDigits(int? length){
    int _length = 0;

    if (length != null && length != 0){
      _length = modulus(length.toDouble())?.toInt() ?? 0;
      _length = _length.toString().length;
    }

    return _length;
  }
  // --------------------
  /// AI TESTED
  static double? modulus(double? num){
    double? _val;

    /// NOTE : GETS THE ABSOLUTE VALUE OF A DOUBLE

    if (num != null){
      _val = math.sqrt(calculateDoublePower(num: num, power: 2));
    }

    return _val;
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
