import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ArrowBackButtonWidget extends StatelessWidget {
  const ArrowBackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15),
        IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                context.pop();
                return;
              } else {
                GoRouter.of(context).go('/');
              }
            },
            icon: SvgPicture.asset('assets/svgs/arrow_left.svg')),
      ],
    );
  }
}
