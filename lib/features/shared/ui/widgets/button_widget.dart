import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.isPrimary = true,
  }) : super(key: key);

  final String text;
  final Function? onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap?.call(),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(312, 46),
        backgroundColor: isPrimary
            ? Theme.of(context).colorScheme.primary
            : Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        text,
      ),
    );
  }
}
