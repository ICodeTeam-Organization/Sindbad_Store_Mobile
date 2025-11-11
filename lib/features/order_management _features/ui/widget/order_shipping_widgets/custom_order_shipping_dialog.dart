import 'package:flutter/material.dart';
import '../order_details_widget/build_dialog_title_shipping.dart';
import 'build_shipping_dialog_content.dart';

class CustomOrderShippingDialog extends StatelessWidget {
  const CustomOrderShippingDialog({
    super.key,
    this.isLoading = false,
    required this.headTitle,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
    required this.dateController,
    required this.numberShippingController,
    required this.mountShippingController,
    required this.anotherCompanyController,
    required this.anotherCompanyNumberController,
  });
  final bool? isLoading;
  final String headTitle;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  //
  final TextEditingController dateController;

  final TextEditingController numberShippingController;

  final TextEditingController mountShippingController;

  final TextEditingController anotherCompanyController;

  final TextEditingController anotherCompanyNumberController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitleShipping(
        headTitle: headTitle,
        dateController: dateController,
        numberShippingController: numberShippingController,
        mountShippingController: mountShippingController,
        anotherCompanyController: anotherCompanyController,
        anotherCompanyNumberController: anotherCompanyNumberController,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildShippingDialogContent(
        isLoading: isLoading,
        firstTitle: firstTitle,
        secondTitle: secondTitle,
        thierdTitle: thierdTitle,
        onPressedSure: onPressedSure,
        dateController: dateController,
        numberShippingController: numberShippingController,
        mountShippingController: mountShippingController,
        anotherCompanyController: anotherCompanyController,
        anotherCompanyNumberController: anotherCompanyNumberController,
      ),
    );
  }
}
