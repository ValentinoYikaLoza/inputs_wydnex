import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inputs_wydnex/models/country_response.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final bool focus;
  const PhoneInput({
    super.key,
    required this.controller,
    this.label = 'Telefono',
    this.error,
    this.focus = false,
  });

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  Country? selectedCountry;

  late List<Country> countries = []; // Lista de países
  late FocusNode phoneFocusNode;
  @override
  void initState() {
    super.initState();
    fetchAndSetCountries(); // Llama a la función para cargar los países al iniciar la aplicación
    phoneFocusNode = FocusNode();
    widget.controller.text = '+54';
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
          .firstWhere((country) => country.name.common.toLowerCase() == 'argentina');
    } catch (e) {
      print('Error al cargar los países: $e');
      // Manejar el error adecuadamente, como mostrar un mensaje al usuario
    }
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
                            widget.controller.text =
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

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su número de teléfono';
    } else if (!RegExp(r'^\+\d{9,14}$').hasMatch(value)) {
      return 'Ingrese un número de teléfono válido (por ejemplo, +51123456789)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      Text(selectedCountry!.idd.suffixes.toString().substring(1,
                          selectedCountry!.idd.suffixes.toString().length - 1)),
                    ],
                  )
                : const Text('nulo'),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              focusNode: phoneFocusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: widget.label,
                errorText: widget.error,
              ),
              validator: validate,
              onEditingComplete: () {
                if (validate(widget.controller.text) == null && widget.focus) {
                  FocusScope.of(context).unfocus(); // Oculta el teclado virtual
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
