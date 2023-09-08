import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vgts_plugin/vgts_plugin.dart';
import 'package:vgts_plugin_example/create_company_viewmodel.dart';
import 'package:vgts_plugin_example/currency.dart';
import 'package:vgts_plugin_example/res/colors.dart';
import 'package:vgts_plugin_example/res/styles.dart';
import 'package:vgts_plugin_example/widgets/dropdown_field.dart';
import 'package:vgts_plugin_example/widgets/edit_text_field.dart';
import 'package:vgts_plugin_example/widgets/image_field.dart';

class CompanyBasicInfoPage
    extends ViewModelBuilderWidget<CreateCompanyViewModel> {
  @override
  Widget builder(
      BuildContext context, CreateCompanyViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackground,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
          title: Text(
            "Create Company",
            style: AppTextStyle.appBarTitle,
            textScaleFactor: 1,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )),
      body: VGTSForm(
        key: viewModel.basicInfoFormKey,
        child: Container(
          color: AppColor.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageField(
                          viewModel.itemImageController,
                          margin: EdgeInsets.only(top: 20),
                        ),
                        EditTextField(
                          "Amount",
                          viewModel.amountController,
                          placeholder: "Enter Amount",
                          //  margin: EdgeInsets.only(top: 15.0),
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                        ),
                        EditTextField(
                          "Percent",
                          viewModel.percentageNumberController,
                          placeholder: "Enter Percent Number",
                          //  margin: EdgeInsets.only(top: 15.0),
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                        ),
                        EditTextField(
                          "Adhaar Number",
                          viewModel.adhaarNumberController,
                          placeholder: "Enter Adhar Number",
                          //  margin: EdgeInsets.only(top: 15.0),
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                        ),
                        EditTextField(
                          "Company Name",
                          viewModel.gstNoController,
                          placeholder: "Enter Company Name",
                          //  margin: EdgeInsets.only(top: 15.0),
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                        ),
                        EditTextField(
                          "Phone no",
                          viewModel.phoneController,
                          margin: EdgeInsets.only(top: 15),
                          onChanged: (value) {},
                          onSubmitted: (val) {
                            print("phone on Submitted");
                            viewModel.emailController.focusNode.requestFocus();
                          },
                        ),
                        EditTextField(
                          "Email Id",
                          viewModel.emailController,
                          margin: EdgeInsets.only(top: 15),
                          onChanged: (value) {},
                          onSubmitted: (val) {
                            viewModel.websiteController.focusNode
                                .requestFocus();
                          },
                        ),
                        EditTextField(
                          "Zip Code",
                          viewModel.zipCodeController,
                          margin: EdgeInsets.only(top: 15),
                          onChanged: (value) {},
                          onSubmitted: (val) {
                            viewModel.websiteController.focusNode
                                .requestFocus();
                          },
                        ),
                        EditTextField(
                          "Website Link",
                          viewModel.websiteController,
                          margin: EdgeInsets.only(top: 15, bottom: 15.0),
                          onChanged: (value) {},
                          onSubmitted: (val) {},
                        ),
                        DropdownField<Currency>.withAdd(
                          "Currency Type",
                          viewModel.currencyController,
                          placeholder: "Select Currency Type",
                          margin: EdgeInsets.only(top: 15),
                          onChange: (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (viewModel.basicInfoFormKey.currentState!.validate()) {}
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  CreateCompanyViewModel viewModelBuilder(BuildContext context) =>
      CreateCompanyViewModel();
}
