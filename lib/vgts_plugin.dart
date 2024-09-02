import 'package:get_it/get_it.dart';
import 'package:vgts_plugin/form/app_model.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';

import 'services/image_picker_services.dart';

export 'form/vgts_form.dart';

GetIt getIt = GetIt.instance;

class VGTSPlugin {
  static init(
      {required FormFieldConfig formFieldConfig,
      required Function modelDeserializer}) {
    getIt.registerLazySingleton(() => formFieldConfig);
    getIt.registerLazySingleton(() => AppModel(modelDeserializer));
    getIt.registerLazySingleton(() => ImagePickerService());
  }
}
