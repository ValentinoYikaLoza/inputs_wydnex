import 'package:flutter/material.dart';

class RucInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const RucInput({
    super.key,
    required this.controller,
    this.label = 'RUC',
    this.error,
    this.focus = false,
  });

  @override
  State<RucInput> createState() => _RucInputState();
}

class _RucInputState extends State<RucInput> {
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu RUC';
    } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'El RUC debe tener exactamente 11 dígitos (por ejemplo, 12345678901)';
    }
    return null; // Devuelve null si no hay error
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
