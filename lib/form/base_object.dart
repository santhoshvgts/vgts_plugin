
import 'package:equatable/equatable.dart';
import 'package:vgts_plugin/form/app_model.dart';
import 'package:vgts_plugin/vgts_plugin.dart';

class BaseObject extends Equatable {

  static AppModel _registeredObject = getIt<AppModel>();

  toDatabaseMap() {

  }

  Future fromMap(Map<String, dynamic> data) async {

  }

  static Future<T> createFromMap<T extends BaseObject>(Map<String, dynamic> data) async {
    return await _registeredObject.modelDeserializer<T>().fromMap(data);
  }

  @override
  List<Object?> get props => [];

}