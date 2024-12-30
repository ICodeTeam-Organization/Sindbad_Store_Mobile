import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildTextField extends StatefulWidget {
  final String hinttext;
  final TextEditingController controller;
  final bool visible;

  const buildTextField({
    super.key,
    required this.hinttext,
    required this.controller,
    required this.visible,
  });

  @override
  State<buildTextField> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buildTextField> {
  String selectedCountryCode = "+967"; // المفتاح الافتراضي
  String selectedFlag = "🇾🇪"; // العلم الافتراضي

  final FocusNode _focusNode = FocusNode(); // إضافة FocusNode

  final List<Map<String, String>> countries = [
    {"code": "+967", "flag": "🇾🇪"}, // اليمن
    {"code": "+966", "flag": "🇸🇦"}, // السعودية
    {"code": "+971", "flag": "🇦🇪"}, // الإمارات
    {"code": "+20", "flag": "🇪🇬"}, // مصر
  ];

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose(); // تأكد من التخلص من FocusNode عند مغادرة الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط في أي مكان خارج الحقول يتم إخفاء الكيبورد
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: 380.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffDDDDDD), width: 1.2),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                focusNode: _focusNode, // ربط FocusNode هنا
                textAlign: TextAlign.start,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: widget.hinttext,
                  hintStyle: TextStyle(
                    color: Color(0xff979797),
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                ),
              ),
            ),
            VerticalDivider(
              color: Color(0xffDDDDDD),
              width: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            if (widget.visible == true)
              DropdownButtonHideUnderline(
                child: DropdownButton<Map<String, String>>(
                  value: countries.firstWhere(
                      (country) => country['code'] == selectedCountryCode),
                  items: countries.map((country) {
                    return DropdownMenuItem<Map<String, String>>(
                      value: country,
                      child: Row(
                        children: [
                          Text(country['flag']!),
                          SizedBox(width: 5.w),
                          Text(country['code']!),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCountryCode = newValue!['code']!;
                      selectedFlag = newValue['flag']!;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
