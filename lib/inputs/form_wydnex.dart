enum Validators {
  required,
  firstName,
  lastName,
  email,
  password,
  phone,
  dni,
  ruc,
  code,
  date,
  url,
  comment,
}

class FormWydnex<T> {
  const FormWydnex({
    required this.value,
    this.validators = const [],
    this.isPure = true,
  });

  final T value;
  final List<Validators> validators;

  bool get isValid => errorMessage == null;

  bool get isInvalid => errorMessage != null;

  String? get errorMessage {

    if (this.validators.contains(Validators.required)) {
      if(value == ''){
        return 'Este campo es requerido';
      }
    }

    if (this.validators.contains(Validators.firstName)) {
      if (!RegExp(r"^[a-zA-ZÀ-ÿ']+(\s[a-zA-ZÀ-ÿ']+)*$")
          .hasMatch(value.toString())) {
        print('> valor incorrecto');

        
        return 'Ingrese un nombre válido (solo letras y espacios)';
      }
    }

    if (this.validators.contains(Validators.lastName)) {
      if (!RegExp(r"^[a-zA-ZÀ-ÿ']+(\s[a-zA-ZÀ-ÿ']+)*$").hasMatch(value.toString())) {
        return 'Ingrese un apellido válido';
      }
    }

    if (this.validators.contains(Validators.email)) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.toString())) {
        return 'Ingrese un correo electrónico válido (por ejemplo, example@example.com)';
      }
    }

    if (this.validators.contains(Validators.password)) {
      if (!RegExp(
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{12,})')
          .hasMatch(value.toString())) {
        return 'La contraseña debe tener al menos 12 caracteres y contener al menos una letra mayúscula, \nuna letra minúscula, un número y un carácter especial (por ejemplo, Q7PQ^ThLS/TH@C3x{Hfqxg6)';
      }
    }

    if (this.validators.contains(Validators.phone)) {
      if (!RegExp(r'^\+\d{9,14}$').hasMatch(value.toString())) {
        return 'Ingrese un número de teléfono válido (por ejemplo, +51123456789)';
      }
    }

    if (this.validators.contains(Validators.dni)) {
      if (!RegExp(r'^[0-9]{8}$').hasMatch(value.toString())) {
        return 'El DNI debe tener exactamente 8 dígitos (por ejemplo, 12345678)';
      }
    }

    if (this.validators.contains(Validators.ruc)) {
      if (!RegExp(r'^[0-9]{11}$').hasMatch(value.toString())) {
        return 'El RUC debe tener exactamente 11 dígitos (por ejemplo, 12345678901)';
      }
    }

    if (this.validators.contains(Validators.code)) {
      if (!RegExp(r'^[A-Z0-9]{5}[-]?[A-Z0-9]{5}[-]?[A-Z0-9]{5}$')
          .hasMatch(value.toString())) {
        return 'Ingrese un código válido con el formato especificado (por ejemplo, KTHJ6-IJ0C6-WK9VN)';
      }
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

    if (this.validators.contains(Validators.date)) {
      // Utilizamos una expresión regular para verificar el formato de fecha (dd/mm/yyyy)
      final RegExp dateRegex = RegExp(
        r'^([0-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/(19|20)\d{2}$',
      );

      if (!dateRegex.hasMatch(value.toString())) {
        return 'Ingrese una fecha válida (formato: dd/mm/yyyy)';
      }

      // Separamos el día, mes y año
      final List<String> parts = value.toString().split('/');
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
    }

    if (this.validators.contains(Validators.url)) {
      if (!RegExp(
              r'^(?:http|https)?://(?:(?:[a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+)+(?:/[\w-]+)*\??(?:[\w-]+=[\w-]+&?)*$')
          .hasMatch(value.toString())) {
        return 'Ingrese una URL válida (por ejemplo, http://www.ejemplo.com)';
      }
    }

    return null;
  }

  final bool isPure;

  FormWydnex<T> touched() {
    return copyWith(
      isPure: false,
    );
  }

  FormWydnex<T> setValue(T newValue) {
    return copyWith(
      value: newValue,
    );
  }

  FormWydnex<T> copyWith({
    bool? isPure,
    T? value,
  }) =>
      FormWydnex<T>(
        isPure: isPure ?? this.isPure,
        validators: this.validators,
        value: value ?? this.value,
      );
}
