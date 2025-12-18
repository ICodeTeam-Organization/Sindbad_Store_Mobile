import 'package:flutter/material.dart';

/// A reusable primary action button with loading state support.
///
/// This button can display an icon, text, and a loading indicator.
/// It supports enabled/disabled states and custom styling.
class PrimaryActionButton extends StatelessWidget {
  /// Whether the button is enabled.
  final bool enabled;

  /// The text to display on the button.
  final String text;

  /// The callback when the button is pressed.
  final VoidCallback? onPressed;

  /// The icon to display on the button.
  final IconData icon;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// The background color of the button (defaults to Color(0xFF093456)).
  final Color? backgroundColor;

  /// The width of the button (defaults to 326).
  final double? width;

  /// The height of the button (defaults to 48).
  final double? height;

  const PrimaryActionButton({
    super.key,
    this.enabled = true,
    required this.text,
    this.onPressed,
    required this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 84,
        maxWidth: 480,
      ),
      child: SizedBox(
        width: width ?? 326,
        height: height ?? 48,
        child: ElevatedButton(
          onPressed: enabled && !isLoading ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? const Color(0xFF093456),
            disabledBackgroundColor:
                (backgroundColor ?? const Color(0xFF093456)).withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (isLoading)
                const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                Icon(
                  icon,
                  color: Colors.white,
                ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
