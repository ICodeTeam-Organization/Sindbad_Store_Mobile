import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class CounterQuantityWidget extends StatefulWidget {
  final int number;
  final ValueChanged<int> onChanged;

  const CounterQuantityWidget({
    super.key,
    required this.number,
    required this.onChanged,
  });

  @override
  State<CounterQuantityWidget> createState() => _CounterQuantityWidgetState();
}

class _CounterQuantityWidgetState extends State<CounterQuantityWidget> {
  late int _counter;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _counter = widget.number;
    _controller = TextEditingController(text: _counter.toString());
  }

  @override
  void didUpdateWidget(CounterQuantityWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Ensure _controller is updated only if the number has changed
    if (widget.number != oldWidget.number) {
      _counter = widget.number;
      _controller.text = _counter.toString();
    }
  }

  void _increment() {
    if (_counter < 999) {
      setState(() {
        _counter++;
        _controller.text = _counter.toString();
        widget.onChanged(_counter);
      });
    }
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        _controller.text = _counter.toString();
        widget.onChanged(_counter);
      });
    }
  }

  void _onTextChanged(String value) {
    int? newValue = int.tryParse(value);

    if (newValue != null && newValue >= 1 && newValue <= 999) {
      setState(() {
        _counter = newValue;
        widget.onChanged(_counter);
      });
    } else if (value.isEmpty || newValue == 0) {
      // Prevent errors when clearing input or entering 0
      setState(() {
        _counter = 1;
        _controller.text = _counter.toString();
        widget.onChanged(_counter);
      });
    } else if (newValue != null && newValue >= 1000) {
      // Prevent input values of 1000 or more
      setState(() {
        _counter = 999;
        _controller.text = _counter.toString();
        widget.onChanged(_counter);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          // Text Input for Counter
          SizedBox(
            height: 30.h,
            width: 40.w,
            child: TextFormField(
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ], // Allow only numeric input
              style: KTextStyle.textStyle13.copyWith(
                color: AppColors.blackLight,
              ),
              onChanged: _onTextChanged,
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
