import 'package:flutter/material.dart';
import 'package:inputs_wydnex/inputs/form_wydnex.dart';

class InputWydnex extends StatefulWidget {
  const InputWydnex({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
  });

  final FormWydnex<String> value;
  final void Function(FormWydnex<String> value) onChanged;
  final String label;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<InputWydnex> createState() => _InputWydnexState();
}

class _InputWydnexState extends State<InputWydnex> {
  late TextEditingController controller;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onChanged(widget.value.touch());
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    controller.dispose();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(20, 10),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            focusNode: _focusNode,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              height: 22 / 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: widget.label,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500),
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
            obscureText:
                widget.obscureText, // Usa el valor de obscureText proporcionado
            controller: controller,
            onChanged: (value) {
              widget.onChanged(
                widget.value.isTouched
                    ? widget.value.setValue(value)
                    : widget.value.touch().setValue(value),
              );
            },
          ),
        ),
        if (widget.value.isInvalid && widget.value.isTouched)
          Padding(
            padding: const EdgeInsets.only(left: 6, top: 6),
            child: Text(
              widget.value.errorMessage.toString(),
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
