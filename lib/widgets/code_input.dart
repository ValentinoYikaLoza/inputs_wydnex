import 'package:flutter/material.dart';

class CodeInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const CodeInput({
    super.key,
    required this.controller,
    this.label = 'Código',
    this.error,
    this.focus = false,
  });

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  bool obscureText = false;
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el código';
    } else if (!RegExp(r'^[A-Z0-9]{5}[-]?[A-Z0-9]{5}[-]?[A-Z0-9]{5}$')
        .hasMatch(value)) {
      return 'Ingrese un código válido con el formato especificado (por ejemplo, KTHJ6-IJ0C6-WK9VN)';
    }
    return null; // Devuelve null si no hay error
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.error, 
      suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      obscureText: obscureText, // Oculta los caracteres de la contraseña
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
