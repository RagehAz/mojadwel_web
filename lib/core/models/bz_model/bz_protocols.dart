import 'package:mojadwel_web/core/models/bz_model/bz_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/services/ldb/ldb.dart';

abstract class BzFireOps {
  // -----------------------------------------------------------------------------
  static const String _fireColl = 'bzz';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> create({
    required BzModel? model,
  }) async {

    if (model != null){

      await OfficialFire.createDoc(
        coll: _fireColl,
        doc: model.id,
        input: model.toMap(
            toJSON: false
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<BzModel?> read({
    required String? id,
  }) async {
    BzModel? _output;

    if (id != null){

      final Map<String, dynamic>? _map = await OfficialFire.readDoc(
        coll: _fireColl,
        doc: id,
      );

      _output = BzModel.decipherMap(
        map: _map,
        fromJSON: false,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<BzModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await OfficialFire.readAllColl(
      coll: _fireColl,
    );

    return BzModel.decipherMaps(
      maps: _maps,
      fromJSON: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> update({
    required BzModel? oldModel,
    required BzModel? newModel,
  }) async {

    if (newModel != null){

      final bool _identical = BzModel.checkModelsAreIdentical(
        model1: oldModel,
        model2: newModel,
      );

      if (_identical == false){

        await create(model: newModel);

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete({
    required String? id,
  }) async {

    if (id != null){

      await OfficialFire.deleteDoc(
        coll: _fireColl,
        doc: id,
      );

    }

  }
// -----------------------------------------------------------------------------
}

abstract class BzLDBOps {
  // -----------------------------------------------------------------------------
  static const String _ldbDoc = 'tempLDBDoc';
  static const String _primaryKey = 'id';
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<void> insert({
    required BzModel? model,
  }) async {

    if (model != null){

      await LDBOps.insertMap(
        docName: _ldbDoc,
        input: model.toMap(toJSON: true),
        primaryKey: 'id',
        // allowDuplicateIDs: false,
      );

    }

  }
  // --------------------
  ///
  static Future<void> insertAll({
    required List<BzModel> models,
  }) async {

    if (Lister.checkCanLoop(models) == true){

      final List<Map<String, dynamic>> _maps = BzModel.cipherToMaps(
        models: models,
        toJSON: true,
      );

      await LDBOps.insertMaps(
        docName: _ldbDoc,
        primaryKey: _primaryKey,
        inputs: _maps,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<BzModel?> read({
    required String? id,
  }) async {
    BzModel? _output;

    if (id != null){

      final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: _ldbDoc,
        primaryKey: _primaryKey,
        id: id,
      );

      _output = BzModel.decipherMap(
        map: _map,
        fromJSON: true,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<BzModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: _ldbDoc,
    );

    return BzModel.decipherMaps(
      maps: _maps,
      fromJSON: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete({
    required String? id,
  }) async {

    if (id != null){

      await LDBOps.deleteMap(
        docName: _ldbDoc,
        primaryKey: _primaryKey,
        objectID: id,
      );

    }

  }
// -----------------------------------------------------------------------------
}

abstract class BzProtocols {
  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> compose({
    required BzModel? model,
  }) async {

    if (model != null){

      await Future.wait(<Future>[

        BzFireOps.create(model: model),

        BzLDBOps.insert(model: model),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  static Future<BzModel?> fetch({
    required String? id,
  }) async {
    BzModel? _output;

    if (id != null){

      _output = await BzLDBOps.read(id: id);

      if (_output == null){

        _output = await BzFireOps.read(id: id);

        if (_output != null){

          await BzLDBOps.insert(model: _output);

        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<BzModel>> fetchAll() async {

    List<BzModel> _models = await BzLDBOps.readAll();

    if (Lister.checkCanLoop(_models) == false){

      _models = await BzFireOps.readAll();

      if (Lister.checkCanLoop(_models) == true){

        await BzLDBOps.insertAll(
          models: _models,
        );

      }

    }

    return _models;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  ///
  static Future<void> renovate({
    required BzModel? oldModel,
    required BzModel? newModel,
  }) async {

    if (newModel != null){

      final bool _identical = BzModel.checkModelsAreIdentical(
        model1: oldModel,
        model2: newModel,
      );

      if (_identical == false){

        await compose(model: newModel);

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Future<void> wipe({
    required String? id,
  }) async {

    if (id != null){

      await Future.wait([

        BzFireOps.delete(id: id),

        BzLDBOps.delete(id: id),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
