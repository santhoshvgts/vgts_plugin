import 'package:flutter/material.dart';

class VGTSForm extends Form {
  VGTSForm({required Key key, required Widget child})
      : super(
            key: key,
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: child,
            ));
}
