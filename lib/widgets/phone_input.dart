import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inputs_wydnex/inputs/form_wydnex.dart';
import 'package:inputs_wydnex/models/country_response.dart';
import 'package:inputs_wydnex/widgets/input_wydnex.dart';

class PhoneInput extends ConsumerStatefulWidget {
  final FormWydnex<String> value;
  final void Function(FormWydnex<String> value) onChanged;
  final String label;
  const PhoneInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends ConsumerState<PhoneInput> {
  Country? selectedCountry;

  late List<Country> countries = []; // Lista de países
  @override
  void initState() {
    super.initState();
    fetchAndSetCountries(); // Llama a la función para cargar los países al iniciar la aplicación
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
      widget.onChanged(
        FormWydnex(value: '+51', validators: widget.value.validators),
      );
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
                            widget.onChanged(
                              FormWydnex(
                                  value:
                                      '$root${suffixes.substring(1, suffixes.length - 1)}',
                                  validators: widget.value.validators),
                            );
                            Navigator.of(context).pop();
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          if (selectedCountry != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () => showCountryDialog(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          selectedCountry!.flags.png,
                          width: 30,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(selectedCountry!.idd.root.toString()),
                        Text(selectedCountry!.idd.suffixes.toString().substring(
                            1,
                            selectedCountry!.idd.suffixes.toString().length -
                                1)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: InputWydnex(
              keyboardType: TextInputType.phone,
              value: widget.value,
              onChanged: (value) {
                widget.onChanged(value);
              },
              label: widget.label,
            ),
          ),
        ],
      ),
    );
  }
}
