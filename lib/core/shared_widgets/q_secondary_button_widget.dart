import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButtonWidget extends StatefulWidget {
  const SecondaryButtonWidget({super.key, required this.secondaryButtonName, required this.onPressed});
  final String secondaryButtonName;
  final GestureTapCallback onPressed;

  @override
  State<SecondaryButtonWidget> createState() => _SecondaryButtonWidgetState();
}

class _SecondaryButtonWidgetState extends State<SecondaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: widget.onPressed,
            child: Container(
              alignment: Alignment.center,
              width: 100.w,
              height: 17.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25.r)
              ),
              child:   Text(widget.secondaryButtonName,textAlign: TextAlign.center ,style: const TextStyle(color: Colors.white)),
              ),
          );
  }
}