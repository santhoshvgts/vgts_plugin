import 'package:vgts_plugin_example/currency.dart';
import 'package:vgts_plugin/form/base_object.dart';

class Models {

  static T object<T extends BaseObject>() {
    switch (T) {
      case Currency:
        return Currency() as T;
    }
    throw "Requested Model not initialised in Base Object";
  }

}