import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/company_shipping_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/company_shipping/cubit/company_shipping_cubit.dart';

String? companyName;

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key, required this.onDataChange(String value)});
  final Function onDataChange;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  void initState() {
    context
        .read<CompanyShippingCubit>()
        .getCompanyShipping(pageNumber: 1, pageSize: 10);
    super.initState();
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
        BlocBuilder<CompanyShippingCubit, CompanyShippingState>(
          builder: (context, state) {
            if (state is CompanyShippingSuccess) {
              List<CompanyShippingEntity> companies =
                  state.companyShippingEntity;

              CompanyShippingEntity newCompany =
                  CompanyShippingEntity(comId: -1, comName: 'اخرى');

              // if (!companies.contains(newCompany)) {
              if (!companies.any((company) =>
                  company.comId == newCompany.comId &&
                  company.comName == newCompany.comName)) {
                companies.add(newCompany);
              }

              return CustomDropdown(
                closedHeaderPadding: const EdgeInsets.all(7),
                items: state.companyShippingEntity
                    .map((company) => company.comName)
                    .toList(),
                // items: companies.map((company) => company.comName).toList(),
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
