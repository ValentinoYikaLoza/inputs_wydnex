import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inputs_wydnex/inputs/form_wydnex.dart';
import 'package:inputs_wydnex/widgets/input_wydnex.dart';
import 'package:intl/intl.dart';

class DateInput extends ConsumerStatefulWidget {
  final FormWydnex<String> value;
  final void Function(FormWydnex<String> value) onChanged;
  final String label;
  const DateInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends ConsumerState<DateInput> {
  @override
  Widget build(BuildContext context) {
    return InputWydnex(
      value: widget.value,
      keyboardType: TextInputType.datetime,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            widget.onChanged(
              FormWydnex(value: DateFormat('dd/MM/yyyy').format(DateTime.now()), validators: widget.value.validators,),
            );
            // widget.value
            //     .setValue(DateFormat('dd/MM/yyyy').format(DateTime.now()));
          });
        },
        child: const Icon(Icons.today),
      ),
      onChanged: (value) {
        widget.onChanged(value);
      },
      label: widget.label,
    );
  }
}
