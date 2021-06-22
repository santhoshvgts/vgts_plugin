import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgts_plugin/form/config/form_field_config.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import 'package:vgts_plugin/vgts_plugin.dart';
import 'field_input_decoration.dart';

class EditTextField extends StatefulWidget {

  FormFieldController controller;

  String label;
  TextStyle? textStyle;
  TextAlign textAlign;

  EdgeInsets margin;

  TextInputAction textInputAction;

  Widget? prefixIcon;
  Widget? suffixIcon;

  String? prefixText;
  String? counterText;

  bool autoFocus = false;
  bool isPasswordField = false;

  bool enabled = true;

  ValueChanged<String>? onChanged = (terms) {};
  ValueChanged<String>? onSubmitted = (terms) {};

  EditTextField(this.label,
      this.controller,
      {this.margin = EdgeInsets.zero,
        this.onSubmitted,
        this.onChanged,
        this.autoFocus = false,
        this.enabled = true,
        this.prefixText,
        this.prefixIcon,
        this.textAlign = TextAlign.left,
        this.textStyle,
        this.textInputAction = TextInputAction.next,
        this.suffixIcon,
        this.counterText
      });

  EditTextField.password(this.label,
      this.controller,
      { this.margin = EdgeInsets.zero,
          this.onSubmitted,
          this.onChanged,
          this.enabled = true,
          this.autoFocus = false,
          this.prefixText,
          this.prefixIcon,
          this.textAlign = TextAlign.left,
          this.textInputAction = TextInputAction.next,
          this.suffixIcon }) {
    isPasswordField = true;
  }

  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  textScaleFactor: 1,
                  style: locator<FormFieldConfig>().labelStyle,
                ),
              ),

              //Todo need to add optional indication
              if (!widget.controller.required)
                Text(
                  "Optional",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.black38, fontSize: 12,),
                ),

            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
          ),

          TextFormField(
            key: widget.controller.fieldKey,
            controller: widget.controller.textEditingController,
            enableInteractiveSelection: true,
            obscureText: widget.isPasswordField && !isVisible ? true : false,
            textInputAction: widget.textInputAction,
            textAlign: widget.textAlign,
            style: widget.textStyle,
            focusNode: widget.controller.focusNode,
            autofocus: widget.autoFocus,
            onChanged: (value){
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onFieldSubmitted: (value) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(value);
              }
            },
            validator: widget.controller.validator,
            enabled: widget.enabled,

            maxLength: widget.controller.maxLength,
            autovalidateMode: AutovalidateMode.disabled,

            maxLines: widget.controller.maxLines,
            minLines: widget.controller.minLines,

            inputFormatters: widget.isPasswordField || widget.controller.textInputType == TextInputType.emailAddress ? [
              FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),
            ] : widget.controller.inputFormatter,

            decoration: inputDecoration,
            keyboardType: widget.controller.textInputType,
            textCapitalization: widget.controller.textCapitalization
          )
        ]
      ),
    );
  }

  Widget _buildPasswordEyeIcon(){
    return GestureDetector(
      child: Icon(isVisible ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
      onTap: () {
        isVisible = !isVisible;
        setState(() {});
      }
    );
  }

  InputDecoration get inputDecoration {
    FormInputDecorationType type = FormInputDecorationType.Box;

    switch(type) {
      case FormInputDecorationType.Box:
        return BoxFieldInputDecoration(
          focusNode: widget.controller.focusNode,
          prefix: widget.prefixText == null ? null : Text("${widget.prefixText} ", style: locator<FormFieldConfig>().textStyle,),
          prefixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
          suffixIcon: widget.isPasswordField ? _buildPasswordEyeIcon() : widget.suffixIcon != null ? widget.suffixIcon : null,
          counterText: widget.counterText != null ? widget.counterText : "",
        );

      case FormInputDecorationType.Box:
      default:
        return BoxFieldInputDecoration(
          focusNode: widget.controller.focusNode,
          prefix: widget.prefixText == null ? null : Text("${widget.prefixText} ", style: locator<FormFieldConfig>().textStyle,),
          prefixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
          suffixIcon: widget.isPasswordField ? _buildPasswordEyeIcon() : widget.suffixIcon != null ? widget.suffixIcon : null,
          counterText: widget.counterText != null ? widget.counterText : "",
        );
    }
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}


