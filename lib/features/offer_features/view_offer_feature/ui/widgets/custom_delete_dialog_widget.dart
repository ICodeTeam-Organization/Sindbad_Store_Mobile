import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomDeleteDialogWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onConfirm;

  const CustomDeleteDialogWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button (X)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
                // Icon
                Icon(Icons.delete, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                // Title
                Text(title,style: KTextStyle.textStyle18.copyWith(color: AppColors.blackDark,),),                const SizedBox(height: 8),
                // Subtitle
                Text(subtitle,style: KTextStyle.textStyle18.copyWith(color: AppColors.greyLight,),),                const SizedBox(height: 8),
                const SizedBox(height: 16),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel Button
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('لا , إلغاء العملية'),
                    ),
                    // Confirm Button
                    ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text('نعم , متابعة الحذف'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
