import 'package:flutter/material.dart';

class FirstNameInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool focus;
  final String? error;
  const FirstNameInput({
    super.key,
    required this.controller,
    this.label = 'Nombres',
    this.error,
    this.focus = false,
  });

  @override
  State<FirstNameInput> createState() => _FirstNameInputState();
}

class _FirstNameInputState extends State<FirstNameInput> {
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un valor';
    } else if (!RegExp(r"^[a-zA-ZÀ-ÿ']+(\s[a-zA-ZÀ-ÿ']+)*$").hasMatch(value)) {
      return 'Ingrese un nombre válido (solo letras y espacios)';
    }
    return null; // Devuelve null si no hay error
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.name,
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
