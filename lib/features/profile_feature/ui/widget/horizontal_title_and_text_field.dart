// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';
// import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/required_text.dart';

// class HorizontalTitleAndTextField extends StatefulWidget {
//   final String title;
//   final TextEditingController info;
//   final bool isDate;
//   final context;

//   const HorizontalTitleAndTextField({
//     super.key,
//     required this.title,
//     required this.info,
//     required this.isDate,
//     this.context,
//   });

//   @override
//   State<HorizontalTitleAndTextField> createState() =>
//       _HorizontalTitleAndTextFieldState();
// }

// class _HorizontalTitleAndTextFieldState
//     extends State<HorizontalTitleAndTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         RequiredText(title: widget.title),
//         SizedBox(
//           width: 40.h,
//         ),
//         Expanded(
//           child: TextFormField(
//             readOnly: widget.isDate,
//             keyboardType: TextInputType.datetime,
//             controller: widget.info,
//             decoration: InputDecoration(
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: InkWell(
//                   onTap: () async {
//                     DateTime? pickeddate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime(2100),
//                       builder: (BuildContext context, Widget? child) {
//                         return Theme(
//                           data: ThemeData.light().copyWith(
//                             colorScheme: ColorScheme.light(
//                               primary:
//                                   AppColors.primary, // Header background color
//                               onPrimary: AppColors.white, // Header text color
//                               onSurface: AppColors
//                                   .blackDark, // Text color on the calendar
//                             ),
//                             textButtonTheme: TextButtonThemeData(
//                               style: TextButton.styleFrom(
//                                 foregroundColor:
//                                     AppColors.blackLight, // Button text color
//                               ),
//                             ),
//                           ),
//                           child: child!,
//                         );
//                       },
//                     );
//                     if (pickeddate != null) {
//                       setState(
//                         () {
//                           widget.info.text =
//                               DateFormat('yyyy/MM/dd').format(pickeddate);
//                         },
//                       );
//                     }
//                   },
//                   child: SvgPicture.asset(
//                     "assets/calendar.svg",
//                   ),
//                 ),
//               ),
//               prefixIconConstraints: BoxConstraints.tight(Size(40, 40)),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: AppColors.greyBorder,
//                   width: 1.0,
//                 ),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: AppColors.primary,
//                   width: 1.0,
//                 ),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/required_text.dart';

class HorizontalTitleAndTextField extends StatefulWidget {
  final String title;
  final TextEditingController info;
  final bool isDate;

  const HorizontalTitleAndTextField({
    super.key,
    required this.title,
    required this.info,
    required this.isDate,
  });

  @override
  State<HorizontalTitleAndTextField> createState() =>
      _HorizontalTitleAndTextFieldState();
}

class _HorizontalTitleAndTextFieldState
    extends State<HorizontalTitleAndTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RequiredText(title: widget.title),
        SizedBox(
          width: 40.h,
        ),
        Expanded(
          child: InkWell(
            // Added GestureDetector to handle taps on the entire row when isDate is true
            onTap: widget.isDate
                ? () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary:
                                  AppColors.primary, // Header background color
                              onPrimary: AppColors.white, // Header text color
                              onSurface: AppColors
                                  .blackDark, // Text color on the calendar
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    AppColors.blackLight, // Button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickeddate != null) {
                      setState(
                        () {
                          widget.info.text =
                              DateFormat('yyyy/MM/dd').format(pickeddate);
                        },
                      );
                    }
                  }
                : null, // No action when isDate is false
            child: AbsorbPointer(
              // Prevents the TextFormField from handling taps when isDate is true
              absorbing: widget.isDate,
              child: SizedBox(
                height: 50.h,
                child: TextFormField(
                  readOnly: widget.isDate,
                  keyboardType: TextInputType.datetime,
                  controller: widget.info,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: widget.isDate
                            ? () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors
                                              .primary, // Header background color
                                          onPrimary: AppColors
                                              .white, // Header text color
                                          onSurface: AppColors
                                              .blackDark, // Text color on the calendar
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors
                                                .blackLight, // Button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickeddate != null) {
                                  setState(
                                    () {
                                      widget.info.text =
                                          DateFormat('yyyy/MM/dd')
                                              .format(pickeddate);
                                    },
                                  );
                                }
                              }
                            : null, // No action when isDate is false
                        child: SvgPicture.asset(
                          "assets/calendar.svg",
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4.h, // Reduced vertical padding
                      horizontal: 4.w, // Reduced horizontal padding
                    ),
                    prefixIconConstraints: BoxConstraints.tight(Size(40, 40)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyBorder,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewHorizontalTitleAndTextField extends StatefulWidget {
  final String title;
  final TextEditingController info;
  final bool isDate;
  final String? initialValue;

  const NewHorizontalTitleAndTextField({
    super.key,
    required this.title,
    required this.info,
    required this.isDate,
    this.initialValue,
  });

  @override
  State<NewHorizontalTitleAndTextField> createState() =>
      _NewHorizontalTitleAndTextFieldState();
}

class _NewHorizontalTitleAndTextFieldState
    extends State<NewHorizontalTitleAndTextField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.info.text.isEmpty) {
      widget.info.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RequiredText(title: widget.title),
        SizedBox(
          width: 40.h,
        ),
        Expanded(
          child: InkWell(
            onTap: widget.isDate
                ? () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.primary,
                              onPrimary: AppColors.white,
                              onSurface: AppColors.blackDark,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.blackLight,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickeddate != null) {
                      setState(() {
                        widget.info.text =
                            DateFormat('yyyy/MM/dd').format(pickeddate);
                      });
                    }
                  }
                : null,
            child: AbsorbPointer(
              absorbing: widget.isDate,
              child: SizedBox(
                height: 50.h,
                child: TextFormField(
                  readOnly: widget.isDate,
                  keyboardType: TextInputType.datetime,
                  controller: widget.info,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: widget.isDate
                            ? () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors.primary,
                                          onPrimary: AppColors.white,
                                          onSurface: AppColors.blackDark,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppColors.blackLight,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickeddate != null) {
                                  setState(() {
                                    widget.info.text = DateFormat('yyyy/MM/dd')
                                        .format(pickeddate);
                                  });
                                }
                              }
                            : null,
                        child: SvgPicture.asset(
                          "assets/calendar.svg",
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 4.w,
                    ),
                    prefixIconConstraints: BoxConstraints.tight(Size(40, 40)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyBorder,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
