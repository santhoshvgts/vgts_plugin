
import 'package:vgts_plugin/form/app_model.dart';
import 'package:vgts_plugin/vgts_plugin.dart';

class BaseObject {

  static AppModel _registeredObject = locator<AppModel>();

  toDatabaseMap() {

  }

  Future fromMap(Map<String, dynamic> data) async {

  }

  static Future<T> createFromMap<T extends BaseObject>(Map<String, dynamic> data) async {
    return await _registeredObject.object<T>().fromMap(data);
  }

}