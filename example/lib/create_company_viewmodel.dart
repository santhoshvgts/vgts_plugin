import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import 'package:vgts_plugin/form/utils/input_formatter.dart';
import 'package:vgts_plugin/form/utils/input_validator.dart';
import 'package:vgts_plugin_example/currency.dart';

class CreateCompanyViewModel extends BaseViewModel {
  final GlobalKey<FormState> basicInfoFormKey = GlobalKey<FormState>();

  ImageFieldController itemImageController =
      ImageFieldController(ValueKey("imgImage"));

  FormFieldController adhaarNumberController = FormFieldController(
      ValueKey("txtCompanyName"),
      inputFormatter: InputFormatter.vehicleFormatter, validator: (p1) {
    return InputValidator.adhaarValidator(p1, requiredText: "Required Aasdasd");
  });

  FormFieldController percentageNumberController = FormFieldController(
      ValueKey("percentage"),
      textInputType: TextInputType.number,
      inputFormatter: [PercentageNumbersFormatter()], validator: (p1) {
    return InputValidator.percentageValidator(p1,
        isDisccount: true, isOptional: false);
  });

  NameFormFieldController companyNameController = NameFormFieldController(
      ValueKey("txtCompanyName"),
      requiredText: "Please Enter Company Name");
  NameFormFieldController fullNameController =
      NameFormFieldController(ValueKey("txtFullName"));
  AmountFormFieldController amountController =
      AmountFormFieldController(ValueKey("amount"));
  PhoneFormFieldController phoneController =
      PhoneFormFieldController(ValueKey("txtPhone"));
  EmailFormFieldController emailController =
      EmailFormFieldController(ValueKey("txtEmail"), required: false);
  TextFormFieldController websiteController = TextFormFieldController(
    ValueKey("txtWebsite"),
  );

  TextFormFieldController address1Controller =
      TextFormFieldController(ValueKey("txtAddress1"), required: true);
  TextFormFieldController address2Controller =
      TextFormFieldController(ValueKey("txtAddress2"), required: true);
  NumberFormFieldController zipCodeController =
      NumberFormFieldController(ValueKey("txtZipCode"), required: true);
  NumberFormFieldController numberFormFieldController =
      NumberFormFieldController(ValueKey("txtAmount"), required: true);

  FormFieldController gstNoController = FormFieldController(
      ValueKey("txtGstNo"),
      required: true,
      maxLength: 15,
      validator: (value) => InputValidator.gstNumberValidator(value));
  // TextFormFieldController gstNoController = TextFormFieldController(ValueKey("txtGstNo"),textCapital: TextCapitalization.characters,required: true);
  TextFormFieldController percentController =
      TextFormFieldController(ValueKey("txtPercent"), required: true);
  TextFormFieldController bankNameController =
      TextFormFieldController(ValueKey("txtBankName"), required: true);
  TextFormFieldController accNoController = TextFormFieldController(
      ValueKey("txtAccNo"),
      required: true,
      inputType: TextInputType.number);
  TextFormFieldController iFscController = TextFormFieldController(
      ValueKey("txtIFSc"),
      textCapital: TextCapitalization.characters,
      required: true);

  DropdownFieldController<Currency> currencyController =
      DropdownFieldController<Currency>(ValueKey("dCurrency"),
          keyId: "id", valueId: "name");

  CreateCompanyViewModel() {
    currencyController.list = [
      Currency(id: 1, name: "INR"),
      Currency(id: 2, name: "USD"),
      Currency(id: 3, name: "SBC"),
      Currency(id: 4, name: "ADS"),
      Currency(id: 5, name: "FGT"),
    ];
  }
}
