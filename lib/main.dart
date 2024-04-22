import 'package:flutter/material.dart';
// import 'package:inputs_wydnex/screens/home.dart';
import 'package:inputs_wydnex/widgets/code_input.dart';
import 'package:inputs_wydnex/widgets/comment_input.dart';
import 'package:inputs_wydnex/widgets/date_input.dart';
import 'package:inputs_wydnex/widgets/dni_input.dart';
import 'package:inputs_wydnex/widgets/email_input.dart';
import 'package:inputs_wydnex/widgets/first_name_input.dart';
import 'package:inputs_wydnex/widgets/last_name_input.dart';
import 'package:inputs_wydnex/widgets/password_input.dart';
import 'package:inputs_wydnex/widgets/phone_input.dart';
import 'package:inputs_wydnex/widgets/ruc_input.dart';
import 'package:inputs_wydnex/widgets/url_input.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: InputsWydnex(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FirstNameInput(
                  controller: firstNameController,
                  label: 'Names',
                  error: firstNameError,
                  focus: false,
                ),
                LastNameInput(
                  controller: lastNameController,
                  error: lastNameError,
                  focus: true,
                ),
                PhoneInput(
                  controller: phoneController,
                  error: phoneError,
                  focus: true,
                ),
                EmailInput(
                  controller: emailController,
                  error: emailError,
                  focus: true,
                ),
                PasswordInput(
                  controller: passwordController,
                  error: passwordError,
                  focus: true,
                ),
                DniInput(
                  controller: dniController,
                  error: dniError,
                  focus: true,
                ),
                RucInput(
                  controller: rucController,
                  error: rucError,
                  focus: true,
                ),
                DateInput(
                  controller: dateController,
                  error: dateError,
                  focus: true,
                ),
                CodeInput(
                  controller: codeController,
                  error: codeError,
                  focus: true,
                ),
                UrlInput(
                  controller: urlController,
                  error: urlError,
                  focus: true,
                ),
                CommentInput(
                  controller: commentsController,
                  error: commentsError,
                ),
                TextButton(onPressed: (){
                  if (firstNameError != ""){
                    print(firstNameController.text);
                  }
                }, child: const Text('click!'))
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
