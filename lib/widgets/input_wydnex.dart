import 'package:flutter/material.dart';
import 'package:inputs_wydnex/inputs/form_wydnex.dart';

class InputWydnex extends StatefulWidget {
  const InputWydnex({
    super.key,
    required this.value, 
    required this.onChanged,
    required this.label,
  });

  final FormWydnex<String> value;
  final void Function(FormWydnex<String> value) onChanged;
  final String label;

  @override
  State<InputWydnex> createState() => _InputWydnexState();
}

class _InputWydnexState extends State<InputWydnex> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onChanged(widget.value.touched());
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.value = controller.value.copyWith(
      text: widget.value.value,
      selection: TextSelection.collapsed(
        offset: controller.selection.end,
      ),
    );
    return TextFormField(
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        height: 22 / 14,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.value.errorMessage,
      ),
      controller: controller,
      onChanged: (value) {
        widget.onChanged(
          !widget.value.isPure
              ? widget.value.setValue(value)
              : widget.value.touched().setValue(value),
              
        );
      },
    );
  }
}
