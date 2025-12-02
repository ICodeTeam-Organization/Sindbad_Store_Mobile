import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class ProductCheckBoxTileWidget extends StatelessWidget {
  final bool valueCheckBox;
  final void Function(bool?)? onChanged;
  final String pathImage;
  final String title;
  const ProductCheckBoxTileWidget({
    super.key,
    required this.valueCheckBox,
    this.onChanged,
    required this.pathImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(children: [
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                value: valueCheckBox,
                onChanged: onChanged,
                title: Row(
                  children: [
                    Image.network(
                      pathImage,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Image.asset(
                          'assets/default_image.png',
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                            'assets/default_image.png'); // Local fallback
                      },
                    ),
                    SizedBox(width: 15.w),
                    SizedBox(
                      width: 100.w,
                      child: Table(
                        children: [
                          TableRow(children: [
                            Text(
                              title,
                              style: KTextStyle.textStyle16.copyWith(
                                color: AppColors.blackDark,
                              ),
                            ),
                          ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ])
          ],
        ),
        Divider(),
      ],
    );
  }
}
