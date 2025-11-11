import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 15),
            child: Text("كلمة المرور",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
        SizedBox(
          width: 380.w,
          child: TextFormField(
            obscureText: obscureText,
            controller: widget.controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              errorMaxLines: 2, // Allows error text to span up to 3 lines
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.2,

                // spacing between lines
              ),
              suffixIcon: obscureText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText; // تغيير حالة الرؤية
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ))
                  : InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText; // تغيير حالة الرؤية
                        });
                      },
                      child: Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
              hintText: "****************",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 1),
                  width: 1,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
    // return Column(
    //   children: [
    //     Align(
    //       alignment: Alignment.centerRight,
    //       child: Padding(
    //         padding: const EdgeInsets.only(bottom: 8.0, right: 15),
    //         child: Text(
    //           widget.label,
    //           style: const TextStyle(
    //             color: Colors.black,
    //             fontSize: 13,
    //             fontWeight: FontWeight.w400,
    //           ),
    //         ),
    //       ),
    //     ),
    //     TextFormField(
    //       controller: widget.controller,
    //       obscureText: obscureText,
    //       decoration: InputDecoration(
    //         suffixIcon: InkWell(
    //           onTap: () => setState(() => obscureText = !obscureText),
    //           child: Icon(
    //             obscureText ? Icons.visibility_off : Icons.visibility,
    //             color: Colors.grey,
    //           ),
    //         ),
    //         hintText: "****************",
    //         filled: true,
    //         fillColor: Colors.white,
    //         border: const OutlineInputBorder(
    //           borderSide: BorderSide(color: Colors.white),
    //         ),
    //       ),

    //       // ✅ Use the validator that comes from outside
    //       validator: widget.validator,
    //     ),
    //   ],
    // );
  }
}
