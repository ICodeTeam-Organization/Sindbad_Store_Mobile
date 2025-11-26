import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_tab_bar_widget.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/function/image_picker_function.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_shipping_widgets/build_info_row_add.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_shipping_widgets/drop_down_widget.dart';
import '../../../../../core/swidgets/new_widgets/store_primary_button.dart';
import '../../../../../core/swidgets/new_widgets/sub_custom_tab_bar.dart';
import '../../function/pdf.dart';
import '../../manager/all_order/all_order_cubit.dart';
import '../../manager/button_disable/button_disable_cubit.dart';
import '../order_shipping_widgets/custom_order_print_dialog.dart';
import '../order_shipping_widgets/custom_order_shipping_dialog.dart';

class ShowPrintAndShippingOrder extends StatefulWidget {
  const ShowPrintAndShippingOrder({
    super.key,
  });

  @override
  State<ShowPrintAndShippingOrder> createState() =>
      _ShowPrintAndShippingOrderState();
}

class _ShowPrintAndShippingOrderState extends State<ShowPrintAndShippingOrder> {
  TextEditingController dateController = TextEditingController();

  TextEditingController numberShippingController = TextEditingController();

  TextEditingController mountShippingController = TextEditingController();

  TextEditingController anotherCompanyController = TextEditingController();

  TextEditingController anotherCompanyNumberController =
      TextEditingController();
  @override
  void dispose() {
    numberShippingController.dispose();
    mountShippingController.dispose();
    anotherCompanyController.dispose();
    anotherCompanyNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int shippingNumber;
    return BlocBuilder<ButtonDisableCubit, ButtonDisableState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StorePrimaryButton(
                disabled: !context
                    .watch<ButtonDisableCubit>()
                    .state
                    .isButtonEnabled(idOrders.toString()),
                width: 150.w,
                title: 'شحن الطلب',
                icon: Icons.local_shipping_outlined,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocConsumer<ShippingCubit, ShippingState>(
                        listener: (context, state) {
                          if (state is ShippingSuccess) {
                            context
                                .read<ButtonDisableCubit>()
                                .enableButtonForOrder(idOrders!.toString());
                            refreshAfterShippingInvoice(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(state.serverMessage.serverMessage),
                              ),
                            );
                          } else if (state is ShippingFailure) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errMessage),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ShippingLoading) {
                            return CustomOrderShippingDialog(
                              isLoading: true,
                              headTitle: 'بيانات فاتورة الشحن',
                              firstTitle: 'تاريخ الفاتورة',
                              secondTitle: 'رقم فاتورة الشحن',
                              thierdTitle: 'الشركة الناقلة',
                              onPressedSure: () async {},
                              dateController: dateController,
                              numberShippingController:
                                  numberShippingController,
                              mountShippingController: mountShippingController,
                              anotherCompanyController:
                                  anotherCompanyController,
                              anotherCompanyNumberController:
                                  anotherCompanyNumberController,
                            );
                          }
                          return CustomOrderShippingDialog(
                            headTitle: 'بيانات فاتورة الشحن',
                            firstTitle: 'تاريخ الفاتورة',
                            secondTitle: 'رقم فاتورة الشحن',
                            thierdTitle: 'الشركة الناقلة',
                            dateController: dateController,
                            numberShippingController: numberShippingController,
                            mountShippingController: mountShippingController,
                            anotherCompanyController: anotherCompanyController,
                            anotherCompanyNumberController:
                                anotherCompanyNumberController,
                            onPressedSure: () async {
                              if (companyName == 'اخرى') {
                                companyName = anotherCompanyController.text;
                              } else {
                                companyName = companyName;
                              }
                              DateTime? dateFormat =
                                  convertToDateTime(dateController.text);
                              await context
                                  .read<ShippingCubit>()
                                  .fetchOrderShipping(
                                      packageId: idPackages!,
                                      invoiceDate: dateFormat ?? DateTime.now(),
                                      // shippingNumber: int.parse(
                                      //     numberShippingController.text),
                                      // shippingCompany: companyName ?? '',
                                      shippingNumber: companyName == 'اخرى' ||
                                              companyId == -1
                                          ? int.parse(
                                              numberShippingController.text)
                                          : 0,
                                      shippingCompany: companyName == 'اخرى' ||
                                              companyId == -1
                                          ? anotherCompanyController.text
                                          : companyName ?? '',
                                      shippingImages: images!,
                                      numberParcels: parcels!,
                                      // shippingCompniesId: 0,
                                      shippingCompniesId:
                                          companyId != -1 ? companyId! : 0,
                                      phoneNumber:
                                          anotherCompanyNumberController.text);
                              dateController.clear();
                              numberShippingController.clear();
                              anotherCompanyController.clear();
                              images = null;
                              parcels = 1;
                              // context.read<ShippingCubit>().enableButton();
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
              StorePrimaryButton(
                icon: Icons.receipt_long_outlined,
                width: 150.w,
                title: 'طباعة العنوان',
                // buttonColor: AppColors.redOpacity,
                // textColor: AppColors.redColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomOrderPrintDialog(
                        headTitle: '  طباعة عنوان الطلب',
                        onPressedPrint: () async {
                          final now = DateTime.now();
                          final randomFileName =
                              '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}-${now.millisecond}';
                          final pdfDocument = await Pdf.generateCenteredText(
                              '$idPackages', parcels!);
                          final file = await Pdf.saveDocument(
                              name: 'invoice_$randomFileName.pdf',
                              pdf: pdfDocument);
                          await Pdf.openFile(file);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('لقد تمت طباعة العنوان بنجاح'),
                              ),
                            );
                          }
                          parcels = 1;
                          // After successful operation, enable the specific order button
                          if (context.mounted) {
                            context
                                .read<ButtonDisableCubit>()
                                .enableButtonForOrder(idOrders.toString());
                          }
                        },
                        onPressedShare: () async {
                          final now = DateTime.now();
                          final randomFileName =
                              '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}-${now.millisecond}';
                          // Ensure pdfDocument is properly initialized and not null
                          final pdfDocument = await Pdf.generateCenteredText(
                              '$idPackages', parcels!);
                          final file = await Pdf.saveDocument(
                              name: 'invoice_$randomFileName.pdf',
                              pdf: pdfDocument);

                          // Now share the file
                          Share.shareXFiles([XFile(file.path)],
                              text: 'Great picture');
                          print('File shared from ${file.path}');
                          parcels = 1;
                          if (context.mounted) {
                            context
                                .read<ButtonDisableCubit>()
                                .enableButtonForOrder(idOrders.toString());
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  DateTime? convertToDateTime(String inputDate) {
    try {
      if (inputDate.isEmpty) {
        return null;
      }
      // Parse the input date string
      DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(inputDate);

      // Add the desired time component
      DateTime dateWithTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        03, // Hour
        00, // Minute
        00, // Second
        000, // Milliseconds
      );
      // Return the DateTime in UTC
      return dateWithTime.toUtc();
    } catch (e) {
      // Return null if the input is invalid
      return null;
    }
  }

  void refreshAfterShippingInvoice(BuildContext context) {
    int subTab = subTabController!.index;
    int tab = tabController!.index;
    if (subTab == 0) {
      context.read<AllOrderCubit>().fetchAllOrder(
        statuses: [2, 3, 4],
        isUrgent: tab == 1,
        pageNumber: 1,
        pageSize: 10,
        // storeId: '85dda4e8-4685-4ae3-b1bb-ea78569fb966'
        // srearchKeyword: ''
      );
    } else if (subTab == 3) {
      context.read<AllOrderCubit>().fetchAllOrder(
        statuses: [4],
        isUrgent: tab == 1,
        pageNumber: 1,
        pageSize: 10,
        // storeId: '85dda4e8-4685-4ae3-b1bb-ea78569fb966'
        // srearchKeyword: ''
      );
    }
  }
}
