import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool focus;
  final String? error;
  const PasswordInput({
    super.key,
    required this.controller,
    this.label = 'Contraseña',
    this.error,
    this.focus = false,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscureText = true;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una contraseña';
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{12,})')
        .hasMatch(value)) {
      return 'La contraseña debe tener al menos 12 caracteres y contener al menos una letra mayúscula, \nuna letra minúscula, un número y un carácter especial (por ejemplo, Q7PQ^ThLS/TH@C3x{Hfqxg6)';
    }
    return null; // Devuelve null si no hay error
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
          FocusScope.of(context).unfocus(); // Oculta el teclado virtual
        }
      },
    );
  }
}
