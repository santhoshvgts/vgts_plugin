import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import 'package:vgts_plugin_example/res/colors.dart';
import 'package:vgts_plugin_example/res/fontsize.dart';
import 'package:vgts_plugin_example/res/styles.dart';

Color _focusBgColor = Color(0xffF8F9FF);
Color _errorBgColor = Color(0xffFFF5F5);
Color _errorColor = Color(0xffEB1414);

TextStyle _errorTextStyle = TextStyle(fontSize: AppFontSize.dp12, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.5, color: _errorColor);
TextStyle _labelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.5, color: AppColor.text);
TextStyle _bodyTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 24 / 16, letterSpacing: 0.15, color: AppColor.text);
TextStyle _hintTextStyle = AppTextStyle.body1Regular.copyWith(color : Color(0xffbdc1c6));

BorderRadius _borderRadius = BorderRadius.circular(4);


class DropdownField<T extends BaseModel> extends StatefulWidget {

  DropdownFieldController<T> controller;

  String title;
  String placeholder;
  EdgeInsets margin;
  EdgeInsets padding;
  Function(T) onChange;
  Function onAddNewPressed;
  bool withAdd = false;
  bool showRequiredHint = true;

  DropdownField(this.title, this.controller, {
    this.placeholder = "",
    this.margin = EdgeInsets.zero,
    this.padding,
    this.showRequiredHint = true,
    this.onChange
  });

  DropdownField.withAdd(this.title, this.controller, {
    this.placeholder = "",
    this.margin = EdgeInsets.zero,
    this.onChange,
    this.padding,
    this.showRequiredHint = true,
    this.onAddNewPressed
  }) {
    this.withAdd = true;
  }

  @override
  _DropdownFieldState<T> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T extends BaseModel> extends State<DropdownField<T>> {

  BorderRadius borderRadius = BorderRadius.circular(5);

  List<DropdownMenuItem<T>> get dropdownMenuItemWidget {
    return widget.controller.list.map<DropdownMenuItem<T>>((T value) {
      Map data = value.toDatabaseMap();
      return DropdownMenuItem<T>(
        value: value,
        child: Text(data[widget.controller.valueId], style: _bodyTextStyle, ),
      );
    }).toList();
  }

  T emptyObject;

  @override
  void initState() {
    if (widget.withAdd) {
      Map<String, dynamic> map = new Map();
      map[widget.controller.keyId] = -1;
      map[widget.controller.valueId] = "Create New";
      BaseModel.createFromMap<T>(map).then((value) {
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
      margin: widget.margin ?? EdgeInsets.all(0),
      child: FormField<T>(
        initialValue: widget.controller.value,
        validator: (value) {
          return widget.controller.validator(value);

          // if (!widget.controller.required && widget.controller.text.isEmpty) {
          //   return null;
          // }
          //
          // if (widget.controller.required || widget.controller.text.isNotEmpty) {
          //   return widget.controller.validator(value);
          // }
          //
          // return null;
        },
        builder: (FormFieldState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding:EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [

                    Expanded(
                      child: Text(
                        widget.title,
                        style: _labelTextStyle,
                      ),
                    ),

                    if (state.hasError && widget.showRequiredHint)
                      Text(
                        state.errorText,
                        style: _errorTextStyle,
                      ),

                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 6),
              ),

              SizedBox(
                height: 40.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: state.hasError ? _errorBgColor : _focusBgColor,
                    border: _outlineInputBorder(state.hasError),
                    borderRadius: _borderRadius
                  ),
                  padding: widget.padding ?? EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: DropdownButton<T>(
                    key: widget.controller.fieldKey,
                    value: widget.controller.value,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColor.black,),
                    iconSize: 20,
                    elevation: 16,
                    itemHeight: 48,
                    hint: Text(widget.placeholder, textScaleFactor: 1, style: _hintTextStyle,),
                    style: _bodyTextStyle,
                    isExpanded: true,
                    focusNode: widget.controller.focusNode,
                    underline: Container(),
                    selectedItemBuilder: (context) {
                      if (widget.controller.value == null) return [
                        Container()
                      ];

                      Map data = widget.controller.value.toDatabaseMap();

                      if (data[widget.controller.keyId] == -1) {
                        return [
                          Container()
                        ];
                      }

                      return List<Widget>.from(dropdownMenuItemWidget);
                    },
                    onChanged: (T value) {
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

                      state.reset();
                      state.didChange(value);

                      if (widget.onChange!= null) {
                        widget.onChange(value);
                      }
                    },
                    items: [
                      ...dropdownMenuItemWidget,

                      if (widget.withAdd && emptyObject != null)
                        DropdownMenuItem<T>(
                            value: emptyObject,
                            onTap: (){
                              if (widget.onAddNewPressed != null)
                                widget.onAddNewPressed();
                            },
                            child: Row(
                              children: [

                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      color: _focusBgColor,
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
                ),
              ),

            ],
          );
        }
      ),
    );
  }

  Border _outlineInputBorder(bool hasError) => Border.all(
    color: hasError ? _errorColor : Color.fromRGBO(0, 0, 0, 0.08),
    width: 1.2
  );

}

