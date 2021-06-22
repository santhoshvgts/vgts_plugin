import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/base_object.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';
import 'package:vgts_plugin/form/field_input_decoration.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import 'package:vgts_plugin/vgts_plugin.dart';

class DropdownField<T extends BaseObject> extends StatefulWidget {

  DropdownFieldController<T> controller;

  String title;
  String placeholder;
  EdgeInsets margin;
  Function(T?)? onChange;
  Function? onAddNewPressed;
  bool withAdd = false;

  DropdownField(this.title, this.controller, {
    this.placeholder = "",
    this.margin = EdgeInsets.zero,
    this.onChange
  });

  DropdownField.withAdd(this.title, this.controller, {
    this.placeholder = "",
    this.margin = EdgeInsets.zero,
    this.onChange,
    this.onAddNewPressed
  }) {
    this.withAdd = true;
  }

  @override
  _DropdownFieldState<T> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T extends BaseObject> extends State<DropdownField<T>> {

  BorderRadius borderRadius = BorderRadius.circular(5);
  FormFieldConfig _config = getIt<FormFieldConfig>();

  List<DropdownMenuItem<T>> get dropdownMenuItemWidget {
    return widget.controller.list.map<DropdownMenuItem<T>>((T value) {
      Map data = value.toDatabaseMap();
      return DropdownMenuItem<T>(
        value: value,
        child: Text(data[widget.controller.valueId], textScaleFactor: 1,),
      );
    }).toList();
  }

  T? emptyObject;

  @override
  void initState() {
    if (widget.withAdd) {
      Map<String, dynamic> map = new Map();
      map[widget.controller.keyId] = -1;
      map[widget.controller.valueId] = "Create New";
      BaseObject.createFromMap<T>(map).then((value) {
        setState(() {
          emptyObject = value;
        });
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin == null ? EdgeInsets.all(0) : widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(widget.title, textScaleFactor: 1, style: _config.labelStyle),

          Padding(padding: EdgeInsets.only(top: 10),),

          DropdownButtonFormField<T>(
            key: widget.controller.fieldKey,
            value: widget.controller.value,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 30,
            elevation: 16,
            hint: Text(widget.placeholder, textScaleFactor: 1,),
            style: _config.textStyle,
            isExpanded: true,
            focusNode: widget.controller.focusNode,
            decoration: inputDecoration,
            validator: widget.controller.validator,
            selectedItemBuilder: (context) {
              if (widget.controller.value == null) return [
                Container()
              ];

              Map data = widget.controller.value!.toDatabaseMap();

              if (data[widget.controller.keyId] == -1) {
                return [
                  Container()
                ];
              }

              return List<Widget>.from(dropdownMenuItemWidget);
            },
            onChanged: (T? value) {
              if (value == null) return;

              if (value.toDatabaseMap()[widget.controller.keyId] == -1) {
                setState(() {
                  widget.controller.setValue(null);
                });
                return;
              }

              setState(() {
                widget.controller.setValue(value);
              });

              if (widget.onChange!= null) {
                widget.onChange!(value);
              }
            },
            items: [
              ...dropdownMenuItemWidget,

              if (widget.withAdd && emptyObject != null)
                DropdownMenuItem<T>(
                    value: emptyObject,
                    onTap: (){
                      if (widget.onAddNewPressed != null)
                        widget.onAddNewPressed!();
                    },
                    child: Row(
                      children: [

                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              color: _config.focusColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(child: Icon(Icons.add, color: Colors.white, size: 18,)),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),

                        Expanded(child: Text("Create New", textScaleFactor: 1,)),
                      ],
                    )
                )

            ],
          ),

        ],
      ),
    );
  }

  InputDecoration get inputDecoration {
    FormInputDecorationType type = FormInputDecorationType.Box;

    switch(type) {
      case FormInputDecorationType.Box:
        return BoxFieldInputDecoration(focusNode: widget.controller.focusNode);

      case FormInputDecorationType.Box:
      default:
        return BoxFieldInputDecoration(focusNode: widget.controller.focusNode);
    }
  }

}

