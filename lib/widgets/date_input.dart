import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const DateInput({
    super.key,
    required this.controller,
    this.label = 'Fecha',
    this.error,
    this.focus = false,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una fecha';
    }

    // Utilizamos una expresión regular para verificar el formato de fecha (dd/mm/yyyy)
    final RegExp dateRegex = RegExp(
      r'^([0-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/(19|20)\d{2}$',
    );

    if (!dateRegex.hasMatch(value)) {
      return 'Ingrese una fecha válida (formato: dd/mm/yyyy)';
    }

    // Separamos el día, mes y año
    final List<String> parts = value.split('/');
    final int day = int.parse(parts[0]);
    final int month = int.parse(parts[1]);
    final int year = int.parse(parts[2]);

    // Verificamos si el año es válido
    if (year < 1900 || year > DateTime.now().year) {
      return 'Ingrese un año válido (entre 1900 y ${DateTime.now().year})';
    }

    // Verificamos si el mes es válido
    if (month < 1 || month > 12) {
      return 'Ingrese un mes válido (entre 01 y 12)';
    }

    // Verificamos si el día es válido para el mes y año dados
    switch (month) {
      case 2: // Febrero
        if (isLeapYear(year)) {
          if (day < 1 || day > 29) {
            return 'Ingrese un día válido para febrero (año bisiesto)';
          }
        } else {
          if (day < 1 || day > 28) {
            return 'Ingrese un día válido para febrero (entre 01 y 28)';
          }
        }
        break;
      case 4: // Abril
      case 6: // Junio
      case 9: // Septiembre
      case 11: // Noviembre
        if (day < 1 || day > 30) {
          return 'Ingrese un día válido para este mes (entre 01 y 30)';
        }
        break;
      default: // Resto de los meses
        if (day < 1 || day > 31) {
          return 'Ingrese un día válido para este mes (entre 01 y 31)';
        }
    }

    return null; // Devuelve null si no hay error
  }

  bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.error,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.text =
                  DateFormat('dd/MM/yyyy').format(DateTime.now());
            });
          },
          child: const Icon(Icons.today),
        ),
      ),
      onChanged: (value) {
        if (value.length == 2 || value.length == 5) {
          widget.controller.text = '$value/';
          widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length),
          );
        }
      },
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
