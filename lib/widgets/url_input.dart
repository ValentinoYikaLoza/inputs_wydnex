import 'package:flutter/material.dart';

class UrlInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const UrlInput({
    super.key,
    required this.controller,
    this.label = 'URL',
    this.error,
    this.focus = false,
  });

  @override
  State<UrlInput> createState() => _UrlInputState();
}

class _UrlInputState extends State<UrlInput> {
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese la URL';
    } else if (!RegExp(
            r'^(?:http|https)?://(?:(?:[a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+)+(?:/[\w-]+)*\??(?:[\w-]+=[\w-]+&?)*$')
        .hasMatch(value)) {
      return 'Ingrese una URL válida (por ejemplo, http://www.ejemplo.com)';
    }
    return null; // Devuelve null si no hay error
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.url,
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
