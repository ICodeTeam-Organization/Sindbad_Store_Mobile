import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarNotifictionWidget extends StatefulWidget {
  final String title;
  final int counter;
  const TabBarNotifictionWidget({
    super.key,
    required this.title,
    required this.counter,
  });

  @override
  State<TabBarNotifictionWidget> createState() =>
      _TabBarNotifictionWidgetState();
}

class _TabBarNotifictionWidgetState extends State<TabBarNotifictionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
          child: Row(
        children: [
          Text(widget.title,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: GoogleFonts.almarai().fontFamily)),
          const SizedBox(width: 5),
          widget.counter == 0
              ? const SizedBox.shrink()
              : CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 15,
                  child: Text(
                    " ${widget.counter.toString()} ",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: GoogleFonts.almarai().fontFamily,
                        color: Colors.white),
                  ),
                )
        ],
      )),
    );
  }
}
