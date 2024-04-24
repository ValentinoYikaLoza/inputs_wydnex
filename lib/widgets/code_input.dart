import 'package:flutter/material.dart';
import 'package:inputs_wydnex/inputs/form_wydnex.dart';
import 'package:inputs_wydnex/widgets/input_wydnex.dart';

class CodeInput extends StatefulWidget {
  final FormWydnex<String> value;
  final void Function(FormWydnex<String> value) onChanged;
  final String label;
  const CodeInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return InputWydnex(
      value: widget.value,
      obscureText: obscureText,
      keyboardType: TextInputType.name,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            // Cambia el estado de _obscureText al contrario
            obscureText = !obscureText;
          });
        },
        child: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
        ),
      ),
      onChanged: (value) {
        widget.onChanged(value);
      },
      label: widget.label,
    );
  }
}
