import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/company_shipping_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/company_shipping/cubit/company_shipping_cubit.dart';

String? companyName;
int? companyId;
bool isLoadingMore = true;

class DropDownWidget extends StatefulWidget {
  // const DropDownWidget({super.key, required this.onDataChange(String value)});
  const DropDownWidget({super.key, required this.onDataChange(int value)});
  final Function onDataChange;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

int pageNumber = 1;

class _DropDownWidgetState extends State<DropDownWidget> {
  ScrollController scrollController = ScrollController();
  List<CompanyShippingEntity> companies = [
    CompanyShippingEntity(comId: -1, comName: 'اخرى')
  ];
  @override
  void initState() {
    context
        .read<CompanyShippingCubit>()
        .getCompanyShipping(pageNumber: 1, pageSize: 10);
    scrollController.addListener(litiner);
    super.initState();
  }

  void litiner() {
    if (isLoadingMore) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context
            .read<CompanyShippingCubit>()
            .getCompanyShipping(pageNumber: ++pageNumber, pageSize: 10);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          'اسم الشركة الناقلة',
          style: KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5.h,
        ),
        BlocConsumer<CompanyShippingCubit, CompanyShippingState>(
          listener: (context, state) {
            if (state is CompanyShippingSuccess) {
              if (state.companyShippingEntity.length < 10) {
                isLoadingMore = false;
              }
              companies.addAll(state.companyShippingEntity);
            }
          },
          builder: (context, state) {
            if (state is CompanyShippingSuccess) {
              // if (!companies.contains(newCompany)) {

              return CustomDropdown(
                closedHeaderPadding: const EdgeInsets.all(7),
                itemsScrollController: scrollController,

                items: companies.map((company) => company.comName).toList(),
                // items: companies.map((company) => company.comName).toList(),
                hintText: "",
                onChanged: (value) {
                  companyName = value;
                  int? comId = companies
                      .firstWhere((company) => company.comName == value)
                      .comId;
                  // widget.onDataChange(value);
                  widget.onDataChange(comId);
                },
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedFillColor: Colors.transparent,
                  closedBorder: Border.all(color: AppColors.grey),
                ),
              );
            } else if (state is CompanyShippingFailure) {
              return CustomDropdown(
                closedHeaderPadding: const EdgeInsets.all(7),
                items: const ['هناك خطا'],
                hintText: "",
                onChanged: (value) {
                  companyName = value;
                  widget.onDataChange(value);
                },
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedFillColor: Colors.transparent,
                  closedBorder: Border.all(color: AppColors.grey),
                ),
              );
            } else {
              return CustomDropdown(
                closedHeaderPadding: const EdgeInsets.all(7),
                items: const ['هناك خطا'],
                hintText: "",
                onChanged: (value) {},
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedFillColor: Colors.transparent,
                  closedBorder: Border.all(color: AppColors.grey),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
