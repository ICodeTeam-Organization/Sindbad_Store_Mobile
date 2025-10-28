import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildTextField extends StatefulWidget {
  final String hinttext;
  final TextEditingController controller;
  final bool? visible;
  final TextInputType? type;

  const buildTextField({
    super.key,
    required this.hinttext,
    required this.controller,
    required this.visible,
    this.type,
  });

  @override
  State<buildTextField> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buildTextField> {
  String selectedCountryCode = "+967"; // المفتاح الافتراضي
  String selectedFlag = "🇾🇪"; // العلم الافتراضي
  late bool isVisable; // حالة الرؤية للحقول
  final FocusNode _focusNode = FocusNode(); // إضافة FocusNode

  final List<Map<String, String>> countries = [
    {"code": "+967", "flag": "🇾🇪"}, // اليمن
    {"code": "+966", "flag": "🇸🇦"}, // السعودية
    {"code": "+971", "flag": "🇦🇪"}, // الإمارات
    {"code": "+20", "flag": "🇪🇬"}, // مصر
  ];

  @override
  void initState() {
    super.initState();
    isVisable = widget.visible ?? true; // تهيئة حالة الرؤية للحقول
  }

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
                obscureText: !isVisable,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },

                controller: widget.controller,
                focusNode: _focusNode, // ربط FocusNode هنا
                textAlign: TextAlign.start,
                keyboardType: widget.type ?? TextInputType.phone,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.red, // لون الخط
                    fontSize: 12.sp, // حجم الخط
                    fontWeight: FontWeight.w600, // سمك الخط
                    height: 1.2,
                  ),
                  hintText: widget.hinttext,
                  suffixIcon: widget.visible == null
                      ? null
                      : isVisable == true
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isVisable = !isVisable; // تغيير حالة الرؤية
                                });
                              },
                              child: Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ))
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isVisable = !isVisable; // تغيير حالة الرؤية
                                });
                              },
                              child: Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(right: 10.w, bottom: 15.h),
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
