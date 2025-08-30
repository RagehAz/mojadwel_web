import 'package:mojadwel_web/core/models/bz_model/bz_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';

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
