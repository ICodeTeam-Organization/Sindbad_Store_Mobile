import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/function/image_picker_function.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/refresh/refresh_page_state.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/build_info_row_add.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/drop_down_widget.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/shared_widgets/new_widgets/sub_custom_tab_bar.dart';
import '../../function/pdf.dart';
import '../../manager/all_order/all_order_cubit.dart';
import '../../manager/button_disable/button_disable_cubit.dart';
import '../../manager/refresh/refresh_page_cubit.dart';
import '../order_shipping_widgets/build_shipping_dialog_content.dart';
import '../order_shipping_widgets/custom_order_print_dialog.dart';
import '../order_shipping_widgets/custom_order_shipping_dialog.dart';
import 'build_dialog_content.dart';
import 'messages.dart';

class ShowPrintAndShippingOrder extends StatelessWidget {
  const ShowPrintAndShippingOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int shippingNumber;
    return BlocBuilder<ButtonDisableCubit, ButtonDisableState>(
      builder: (context, state) {
        return BlocBuilder<RefreshPageCubit, RefreshPageState>(
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
                        builder: (context) {
                          return CustomOrderShippingDialog(
                            headTitle: 'بيانات فاتورة الشحن',
                            firstTitle: 'تاريخ الفاتورة',
                            secondTitle: 'رقم فاتورة الشحن',
                            thierdTitle: 'الشركة الناقلة',
                            onPressedSure: () async {
                              try {
                                if (companyName == 'اخرى') {
                                  companyName = anotherCompanyConroller.text;
                                } else {
                                  companyName = companyName;
                                }
                                DateTime? dateFormat =
                                    convertToDateTime(dateConroller.text);
                                await context
                                    .read<ShippingCubit>()
                                    .fetchOrderShipping(
                                        packageId: idPackages!,
                                        invoiceDate:
                                            dateFormat ?? DateTime.now(),
                                        shippingNumber: shippingNumber =
                                            int.parse(
                                                numberShippingConroller.text),
                                        shippingCompany: companyName ?? '',
                                        shippingImages: images!,
                                        numberParcels: parcels!);
                                // After successful operation, enable the specific order button
                                // ignore: use_build_context_synchronously
                                context
                                    .read<ButtonDisableCubit>()
                                    .enableButtonForOrder(idOrders!.toString());
                                // ignore: use_build_context_synchronously
                                context.pop();
                                // ignore: use_build_context_synchronously
                                context.pop();
                                // ignore: use_build_context_synchronously
                                refreshAfterShippingInvoice(context);
                                showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (context) {
                                    return BlocBuilder<ShippingCubit,
                                        ShippingState>(
                                      builder: (context, state) {
                                        if (state is ShippingSuccess) {
                                          return Messages(
                                            isTrue:
                                                state.serverMessage.isSuccess,
                                            trueMessage: 'لقد تم الشحن بنجاح',
                                            falseMessage:
                                                'هناك خطاء في العملية',
                                          );
                                        } else if (state is ShippingFailure) {
                                          return Messages(
                                            isTrue: false,
                                            trueMessage: 'لقد تم الشحن بنجاح',
                                            falseMessage:
                                                'هناك خطاء في العملية',
                                          );
                                        } else {
                                          return Text("يوجد خطا");
                                        }
                                      },
                                    );
                                  },
                                );
                                dateConroller.clear();
                                numberShippingConroller.clear();
                                anotherCompanyConroller.clear();
                                parcels = 1;
                                // context.read<ShippingCubit>().enableButton();
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text('هنالك خطا ما  $e'),
                                //   ),
                                // );
                                // ignore: use_build_context_synchronously
                                // Navigator.of(context).pop();
                                showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (context) {
                                    // return BlocBuilder<ShippingCubit,
                                    //     ShippingState>(
                                    //   builder: (context, state) {
                                    //     if (state is ShippingSuccess) {
                                    return Messages(
                                      isTrue: false,
                                      trueMessage: '',
                                      falseMessage: 'هناك خطاء في العملية',
                                    );
                                    //     } else if (state is ShippingFailure) {
                                    //       return Messages(
                                    //         isTrue: false,
                                    //         trueMessage: '',
                                    //         falseMessage:
                                    //             'هناك خطاء في العملية',
                                    //       );
                                    //     } else {
                                    //       return Text("يوجد خطا");
                                    //     }
                                    //   },
                                    // );
                                  },
                                );
                              }
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
                              final pdfDocument =
                                  await Pdf.generateCenteredText(
                                      '$idPackages', parcels!);
                              final file = await Pdf.saveDocument(
                                  name: 'invoice_$randomFileName.pdf',
                                  pdf: pdfDocument);
                              await Pdf.openFile(file);
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Messages(
                                    isTrue: true,
                                    trueMessage:
                                        'لقد تم طباعة ملصق انتقل الى شحن الطلبات',
                                    falseMessage: 'هناك خطاء في العملية',
                                  );
                                },
                              );
                              parcels = 1;
                              // After successful operation, enable the specific order button
                              context
                                  .read<ButtonDisableCubit>()
                                  .enableButtonForOrder(idOrders.toString());
                            },
                            onPressedShare: () async {
                              final now = DateTime.now();
                              final randomFileName =
                                  '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}-${now.millisecond}';
                              // Ensure pdfDocument is properly initialized and not null
                              final pdfDocument =
                                  await Pdf.generateCenteredText(
                                      '$idPackages', parcels!);
                              final file = await Pdf.saveDocument(
                                  name: 'invoice_$randomFileName.pdf',
                                  pdf: pdfDocument);

                              // Now share the file
                              if (file != null) {
                                Share.shareXFiles([XFile(file.path)],
                                    text: 'Great picture');
                                print('File shared from ${file.path}');
                              } else {
                                print('File does not exist to share.');
                              }
                              parcels = 1;
                              context
                                  .read<ButtonDisableCubit>()
                                  .enableButtonForOrder(idOrders.toString());
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
      },
    );
  }

  DateTime? convertToDateTime(String inputDate) {
    try {
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
    if (subTabController!.index == 0) {
      context.read<AllOrderCubit>().fetchAllOrder(
            isUrgen: false,
            canceled: false,
            delevred: false,
            noInvoice: false,
            unpaied: false,
            paied: false,
            pageNumber: 1,
            pageSize: 100,
            // storeId: '85dda4e8-4685-4ae3-b1bb-ea78569fb966'
            // srearchKeyword: ''
          );
    } else if (subTabController!.index == 3) {
      context.read<AllOrderCubit>().fetchAllOrder(
            isUrgen: false,
            canceled: false,
            delevred: false,
            noInvoice: false,
            unpaied: false,
            paied: true,
            pageNumber: 1,
            pageSize: 100,
            // storeId: '85dda4e8-4685-4ae3-b1bb-ea78569fb966'
            // srearchKeyword: ''
          );
    }
  }
}
