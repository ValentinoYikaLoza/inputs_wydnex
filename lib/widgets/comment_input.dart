import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const CommentInput({
    super.key,
    required this.controller,
    this.label = 'Comentarios u Observaciones (Opcional)',
    this.error,
    this.focus = false,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  String? validate(String? value) {
    // No se requiere validación para comentarios u observaciones
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.text,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          labelText: widget.label,
          errorText: widget.error,
        ),
        validator: validate,
      ),
    );
  }
}
