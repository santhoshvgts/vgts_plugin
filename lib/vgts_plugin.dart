
import 'package:get_it/get_it.dart';
import 'package:vgts_plugin/form/app_model.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';

export 'form/dropdown_field.dart';
export 'form/edit_text_field.dart';
export 'form/vgts_form.dart';

GetIt locator = GetIt.instance;

class VGTSPlugin {

  init({ required FormFieldConfig editTextFieldConfig, required Function objectType}) {
    locator.registerLazySingleton(() => editTextFieldConfig);
    locator.registerLazySingleton(() => AppModel(objectType));
  }

  setupLocator(){

  }

}