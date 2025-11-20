import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.value,
    required this.label,
    this.isLoading = false, // new loading flag
  });

  final String value;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Field name
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          // Right side: either text or Lottie
          Flexible(
            child: Align(
              alignment: Alignment.center,
              child: isLoading
                  ? SizedBox(
                      width: 30,
                      height: 30,
                      child: Lottie.asset(
                        'assets/jsons/loading_colour.json',
                        fit: BoxFit.contain,
                      ),
                    )
                  : Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.end,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
