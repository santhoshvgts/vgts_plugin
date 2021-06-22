import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';
import 'package:vgts_plugin/vgts_plugin.dart';
import 'package:vgts_plugin_example/add_company_basicinfo.dart';
import 'package:vgts_plugin_example/app_model.dart';
import 'package:vgts_plugin_example/res/colors.dart';
import 'package:vgts_plugin_example/res/styles.dart';

void main() {

  VGTSPlugin().init(
    editTextFieldConfig: AppStyle.editTextFieldConfig,
    objectType: Models.object
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompanyBasicInfoPage(),
    );
  }
}
