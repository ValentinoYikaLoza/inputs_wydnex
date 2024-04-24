import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inputs_wydnex/inputs/provider.dart';
import 'package:inputs_wydnex/widgets/input_wydnex.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final inputs = ref.watch(inputsProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputWydnex(
                  value: inputs.firstName,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeFirstName(value);
                  },
                  label: 'First Name',
                ),
                InputWydnex(
                  value: inputs.lastName,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeLastName(value);
                  },
                  label: 'Last Name',
                ),
                InputWydnex(
                  value: inputs.email,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeEmail(value);
                  },
                  label: 'Email',
                ),
                InputWydnex(
                  value: inputs.password,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changePassword(value);
                  },
                  label: 'Password',
                ),
                InputWydnex(
                  value: inputs.phone,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changePhone(value);
                  },
                  label: 'Phone',
                ),
                InputWydnex(
                  value: inputs.dni,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeDNI(value);
                  },
                  label: 'DNI',
                ),
                InputWydnex(
                  value: inputs.ruc,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeRUC(value);
                  },
                  label: 'RUC',
                ),
                InputWydnex(
                  value: inputs.code,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeCode(value);
                  },
                  label: 'Code',
                ),
                InputWydnex(
                  value: inputs.date,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeDate(value);
                  },
                  label: 'Date',
                ),
                InputWydnex(
                  value: inputs.url,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeURL(value);
                  },
                  label: 'URL',
                ),
                InputWydnex(
                  value: inputs.comment,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeComment(value);
                  },
                  label: 'Comment',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}