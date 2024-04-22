import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inputs_wydnex/models/country_response.dart';
import 'package:intl/intl.dart';

class InputsWydnex extends StatefulWidget {
  const InputsWydnex({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputsWydnexState createState() => _InputsWydnexState();
}

class _InputsWydnexState extends State<InputsWydnex> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? dniError;
  String? rucError;
  String? codeError;
  String? urlError;
  String? dateError;
  String? commentsError;

  Country? selectedCountry;

  late List<Country> countries = []; // Lista de países
  late FocusNode phoneFocusNode;

  @override
  void initState() {
    super.initState();
    fetchAndSetCountries(); // Llama a la función para cargar los países al iniciar la aplicación
    phoneFocusNode = FocusNode();
    phoneController.text = '+51';
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  static Future<List<Country>> fetchCountries() async {
    try {
      final response = await Dio().get('https://restcountries.com/v3.1/all');
      final List<dynamic> countryDataList = response.data;
      if (countryDataList.isEmpty) {
        print('La lista de datos del país está vacía');
        return [];
      }

      final List<Country> countries = countryDataList
          .map((countryData) {
            try {
              return Country.fromJson(countryData);
            } catch (e) {
              //print('Error al convertir los datos del país: $e');
              return null;
            }
          })
          .whereType<Country>() // Filtrar elementos nulos
          .toList();

      countries.sort((a, b) => a.name.common.compareTo(b.name.common));

      //print('Países convertidos con éxito: $countries');

      return countries;
    } catch (e) {
      throw 'Ocurrió un error> $e';
    }
  }

  Future<void> fetchAndSetCountries() async {
    try {
      final List<Country> fetchedCountries = await fetchCountries();
      setState(() {
        countries.addAll(fetchedCountries);
      });
      // Assuming 'peru' is a Country object or a way to identify the desired country:
      selectedCountry ??= fetchedCountries
          .firstWhere((country) => country.name.common.toLowerCase() == 'peru');
    } catch (e) {
      print('Error al cargar los países: $e');
      // Manejar el error adecuadamente, como mostrar un mensaje al usuario
    }
  }

  void validateInputs() {
    setState(() {
      firstNameError = validateName(firstNameController.text);
      lastNameError = validateName(lastNameController.text);
      emailError = validateEmail(emailController.text);
      phoneError = validatePhone(phoneController.text);
    });

    if (firstNameError == null &&
        lastNameError == null &&
        emailError == null &&
        phoneError == null &&
        passwordError == null &&
        dniError == null &&
        rucError == null &&
        codeError == null &&
        urlError == null &&
        dateError == null &&
        commentsError == null) {
      print('Nombre: ${firstNameController.text}');
      print('Apellido: ${lastNameController.text}');
      print('Correo Electrónico: ${emailController.text}');
      print('Teléfono: ${phoneController.text}');
      print('Contraseña: ${passwordController.text}');
      print('RUC: ${rucController.text}');
      print('Código: ${codeController.text}');
      print('URL: ${urlController.text}');
      print('Fecha: ${dateController.text}');
      print('Comentarios u Observaciones: ${commentsController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos enviados correctamente')),
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un valor';
    } else if (!RegExp(r"^[a-zA-ZÀ-ÿ']+(\s[a-zA-ZÀ-ÿ']+)*$").hasMatch(value)) {
      return 'Ingrese un nombre válido (solo letras y espacios)';
    }
    return null; // Devuelve null si no hay error
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo electrónico';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Ingrese un correo electrónico válido (por ejemplo, example@example.com)';
    }
    return null; // Devuelve null si no hay error
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su número de teléfono';
    } else if (!RegExp(r'^\+\d{9,14}$').hasMatch(value)) {
      return 'Ingrese un número de teléfono válido (por ejemplo, +51 123456789)';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una contraseña';
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{12,})')
        .hasMatch(value)) {
      return 'La contraseña debe tener al menos 12 caracteres y contener al menos una letra mayúscula, \nuna letra minúscula, un número y un carácter especial (por ejemplo, Q7PQ^ThLS/TH@C3x{Hfqxg6)';
    }
    return null; // Devuelve null si no hay error
  }

  String? validateDNI(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su DNI';
    } else if (!RegExp(r'^[0-9]{8}$').hasMatch(value)) {
      return 'El DNI debe tener exactamente 8 dígitos (por ejemplo, 12345678)';
    }
    return null;
  }

  String? validateRUC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu RUC';
    } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'El RUC debe tener exactamente 11 dígitos (por ejemplo, 12345678901)';
    }
    return null; // Devuelve null si no hay error
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el código';
    } else if (!RegExp(r'^[A-Z0-9]{5}[-]?[A-Z0-9]{5}[-]?[A-Z0-9]{5}$')
        .hasMatch(value)) {
      return 'Ingrese un código válido con el formato especificado (por ejemplo, KTHJ6-IJ0C6-WK9VN)';
    }
    return null; // Devuelve null si no hay error
  }

  String? validateURL(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese la URL';
    } else if (!RegExp(
            r'^(?:http|https)?://(?:(?:[a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+)+(?:/[\w-]+)*\??(?:[\w-]+=[\w-]+&?)*$')
        .hasMatch(value)) {
      return 'Ingrese una URL válida (por ejemplo, http://www.ejemplo.com)';
    }
    return null; // Devuelve null si no hay error
  }

  String? validateDate(String? value) {
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

  String? validateComments(String? value) {
    // No se requiere validación para comentarios u observaciones
    return null;
  }

  void showCountryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar país'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final Country country = countries[index];
                      String suffixes = '';
                      String root = '';

                      if (country.idd.suffixes != null) {
                        suffixes = country.idd.suffixes!.toString();

                        if (country.idd.suffixes!.length > 1) {
                          suffixes = '[]';
                        }
                      }

                      if (country.idd.root != null) {
                        root = country.idd.root.toString();
                      }

                      return ListTile(
                        leading: Image.network(country.flags.png,
                            width: 30, height: 20),
                        title: Text(
                            ' $root${suffixes.substring(1, suffixes.length - 1)} ${country.name.common}'),
                        onTap: () {
                          setState(() {
                            selectedCountry = countries[index];
                            phoneController.text =
                                '$root${suffixes.substring(1, suffixes.length - 1)}';
                            Navigator.of(context).pop();
                            // Remueve el foco del widget actual
                            FocusScope.of(context).requestFocus(FocusNode());
                            // Enfoca el campo de texto phoneController después de un pequeño retraso
                            Future.delayed(Duration.zero, () {
                              phoneFocusNode.requestFocus();
                            });
                          });
                        },
                      );
                    },
                    childCount: countries.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario con Validación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: firstNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Nombres',
                  errorText: firstNameError,
                ),
                validator: validateName,
                onEditingComplete: () {
                  if (validateName(firstNameController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              TextFormField(
                controller: lastNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                  errorText: lastNameError,
                ),
                validator: validateName,
                onEditingComplete: () {
                  if (validateName(lastNameController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  errorText: emailError,
                ),
                validator: validateEmail,
                onEditingComplete: () {
                  if (validateEmail(emailController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: selectedCountry != null
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () => showCountryDialog(),
                                  child: Image.network(
                                    selectedCountry!.flags.png,
                                    width: 30,
                                    height: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(selectedCountry!.idd.root.toString()),
                                Text(selectedCountry!.idd.suffixes
                                    .toString()
                                    .substring(
                                        1,
                                        selectedCountry!.idd.suffixes
                                                .toString()
                                                .length -
                                            1)),
                              ],
                            )
                          : const Text('nulo'),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          errorText: phoneError,
                        ),
                        validator: validatePhone,
                        onEditingComplete: () {
                          if (validatePhone(phoneController.text) == null) {
                            FocusScope.of(context)
                                .unfocus(); // Oculta el teclado virtual
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  errorText: passwordError,
                ),
                obscureText: true, // Oculta los caracteres de la contraseña
                validator: validatePassword,
                onEditingComplete: () {
                  if (validatePassword(passwordController.text) == null) {
                    FocusScope.of(context)
                        .unfocus(); // Oculta el teclado virtual
                  }
                },
              ),
              TextFormField(
                controller: dniController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'DNI',
                  errorText: dniError,
                ),
                validator: validateDNI,
                onEditingComplete: () {
                  if (validateDNI(dniController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              TextFormField(
                controller: rucController,
                autovalidateMode:
                    AutovalidateMode.onUserInteraction, // Teclado numérico
                decoration: InputDecoration(
                  labelText: 'RUC',
                  errorText: rucError,
                ),
                validator: validateRUC,
                onEditingComplete: () {
                  if (validateRUC(rucController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              TextFormField(
                controller: codeController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Código',
                  hintText: 'Ingresa el código',
                  errorText: codeError,
                ),
                validator: validateCode,
                onEditingComplete: () {
                  if (validateCode(codeController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              TextFormField(
                controller: urlController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'URL',
                  hintText: 'Ingresa la URL',
                  errorText: urlError,
                ),
                validator: validateURL,
                onEditingComplete: () {
                  if (validateURL(urlController.text) == null) {
                    FocusScope.of(context)
                        .nextFocus(); // Mueve el foco al siguiente campo de entrada si el campo actual está validado
                  }
                },
              ),
              TextFormField(
                controller: dateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  hintText: 'Seleccione una fecha',
                  errorText: dateError,
                ),
                validator: validateDate,
              ),
              SizedBox(
                height: 120,
                child: TextFormField(
                  controller: commentsController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    labelText: 'Comentarios u Observaciones (Opcional)',
                    errorText: commentsError,
                  ),
                  validator: validateComments,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: validateInputs,
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
