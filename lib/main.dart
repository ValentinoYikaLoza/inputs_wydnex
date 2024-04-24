import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inputs_wydnex/inputs/provider.dart';
import 'package:inputs_wydnex/widgets/code_input.dart';
import 'package:inputs_wydnex/widgets/date_input.dart';
import 'package:inputs_wydnex/widgets/input_wydnex.dart';
import 'package:inputs_wydnex/widgets/password_input.dart';
import 'package:inputs_wydnex/widgets/phone_input.dart';

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
                  keyboardType: TextInputType.name,
                  label: 'First Name',
                ),
                InputWydnex(
                  value: inputs.lastName,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeLastName(value);
                  },
                  keyboardType: TextInputType.name,
                  label: 'Last Name',
                ),
                InputWydnex(
                  value: inputs.email,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeEmail(value);
                  },
                  keyboardType: TextInputType.emailAddress,
                  label: 'Email',
                ),
                PasswordInput(
                  value: inputs.password,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changePassword(value);
                  },
                  label: 'Password',
                ),
                PhoneInput(
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
                  keyboardType: TextInputType.number,
                  label: 'DNI',
                ),
                InputWydnex(
                  value: inputs.ruc,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeRUC(value);
                  },
                  keyboardType: TextInputType.number,
                  label: 'RUC',
                ),
                CodeInput(
                  value: inputs.code,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeCode(value);
                  },
                  label: 'Code',
                ),
                DateInput(
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
                  keyboardType: TextInputType.url,
                  label: 'URL',
                ),
                InputWydnex(
                  value: inputs.comment,
                  onChanged: (value) {
                    ref.read(inputsProvider.notifier).changeComment(value);
                  },
                  keyboardType: TextInputType.multiline,
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