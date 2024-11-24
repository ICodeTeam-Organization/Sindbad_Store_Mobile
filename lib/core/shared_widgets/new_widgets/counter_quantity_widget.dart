import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CounterQuantityWidget extends StatefulWidget {
  final int number;
  final ValueChanged<int> onChanged;

  const CounterQuantityWidget({
    Key? key,
    required this.number,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CounterQuantityWidget> createState() => _CounterQuantityWidgetState();
}

class _CounterQuantityWidgetState extends State<CounterQuantityWidget> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.number; // Initialize the counter with the initial value
  }

  @override
  void didUpdateWidget(CounterQuantityWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the counter when the parent passes a new number value
    if (widget.number != oldWidget.number) {
      setState(() {
        _counter = widget.number;
      });
    }
  }

  void _increment() {
    setState(() {
      _counter++;
      widget.onChanged(_counter); // Notify parent of the new value
    });
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        widget.onChanged(_counter); // Notify parent of the new value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Increment Button
          InkWell(
            onTap: _increment,
            child: Container(
              alignment: Alignment.center,
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.greyBorder,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primary,
                size: 10,
              ),
            ),
          ),
          SizedBox(width: 5.w),
          // Display Counter in a TextField
          SizedBox(
            height: 30.h,
            width: 30.w,
            child: TextFormField(
              controller: TextEditingController(text: _counter.toString()),
              textAlign: TextAlign.center,
              style: KTextStyle.textStyle11.copyWith(
                color: AppColors.blackLight,
              ),
              readOnly: true, // Makes the text field read-only
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4.h,
                  horizontal: 4.w,
                ),
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
          SizedBox(width: 5.w),
          // Decrement Button
          InkWell(
            onTap: _decrement,
            child: Container(
              alignment: Alignment.center,
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.greyBorder,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.remove,
                color: AppColors.primary,
                size: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
