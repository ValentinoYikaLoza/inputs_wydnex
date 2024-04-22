import 'package:flutter/material.dart';

class DniInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const DniInput({
    super.key,
    required this.controller,
    this.label = 'DNI',
    this.error,
    this.focus = false,
  });

  @override
  State<DniInput> createState() => _DniInputState();
}

class _DniInputState extends State<DniInput> {
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su DNI';
    } else if (!RegExp(r'^[0-9]{8}$').hasMatch(value)) {
      return 'El DNI debe tener exactamente 8 dígitos (por ejemplo, 12345678)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.error,
      ),
      validator: validate,
      onEditingComplete: () {
        if (validate(widget.controller.text) == null && widget.focus) {
          FocusScope.of(context)
              .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
        }
      },
    );
  }
}
