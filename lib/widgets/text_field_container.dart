import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.child,
    this.errorMessage,
    required this.color,
  });
  final Widget child;
  final Color color;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
        if (errorMessage != null)
          Container(
            padding: const EdgeInsets.only(top: 6, left: 6),
            child: Text(
              '$errorMessage',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.red,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
      ],
    );
  }
}
