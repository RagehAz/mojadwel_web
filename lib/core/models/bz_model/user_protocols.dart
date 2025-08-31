import 'package:mojadwel_web/core/models/bz_model/user_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/services/ldb/ldb.dart';

abstract class UserFireOps {
  // -----------------------------------------------------------------------------
  static const String _fireColl = 'users';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> create({
    required UserModel? model,
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
  static Future<UserModel?> read({
    required String? id,
  }) async {
    UserModel? _output;

    if (id != null){

      final Map<String, dynamic>? _map = await OfficialFire.readDoc(
        coll: _fireColl,
        doc: id,
      );

      _output = UserModel.decipherMap(
        map: _map,
        fromJSON: false,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<UserModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await OfficialFire.readAllColl(
      coll: _fireColl,
    );

    return UserModel.decipherMaps(
      maps: _maps,
      fromJSON: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> update({
    required UserModel? oldModel,
    required UserModel? newModel,
  }) async {

    if (newModel != null){

      final bool _identical = UserModel.checkModelsAreIdentical(
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

abstract class UserLDBOps {
  // -----------------------------------------------------------------------------
  static const String _ldbDoc = 'tempLDBDoc';
  static const String _primaryKey = 'id';
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<void> insert({
    required UserModel? model,
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
    required List<UserModel> models,
  }) async {

    if (Lister.checkCanLoop(models) == true){

      final List<Map<String, dynamic>> _maps = UserModel.cipherToMaps(
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
  static Future<UserModel?> read({
    required String? id,
  }) async {
    UserModel? _output;

    if (id != null){

      final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: _ldbDoc,
        primaryKey: _primaryKey,
        id: id,
      );

      _output = UserModel.decipherMap(
        map: _map,
        fromJSON: true,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<UserModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: _ldbDoc,
    );

    return UserModel.decipherMaps(
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

abstract class UserProtocols {
  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> compose({
    required UserModel? model,
  }) async {

    if (model != null){

      await Future.wait(<Future>[

        UserFireOps.create(model: model),

        UserLDBOps.insert(model: model),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  static Future<UserModel?> fetch({
    required String? id,
  }) async {
    UserModel? _output;

    if (id != null){

      _output = await UserLDBOps.read(id: id);

      if (_output == null){

        _output = await UserFireOps.read(id: id);

        if (_output != null){

          await UserLDBOps.insert(model: _output);

        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<UserModel>> fetchAll() async {

    List<UserModel> _models = await UserLDBOps.readAll();

    if (Lister.checkCanLoop(_models) == false){

      _models = await UserFireOps.readAll();

      if (Lister.checkCanLoop(_models) == true){

        await UserLDBOps.insertAll(
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
    required UserModel? oldModel,
    required UserModel? newModel,
  }) async {

    if (newModel != null){

      final bool _identical = UserModel.checkModelsAreIdentical(
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

        UserFireOps.delete(id: id),

        UserLDBOps.delete(id: id),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
