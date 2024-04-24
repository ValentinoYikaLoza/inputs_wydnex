import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inputs_wydnex/inputs/form_wydnex.dart';

final inputsProvider =
    StateNotifierProvider<InputsNotifier, InputsState>((ref) {
  return InputsNotifier(ref);
});

class InputsNotifier extends StateNotifier<InputsState> {
  InputsNotifier(this.ref) : super(InputsState());
  final StateNotifierProviderRef ref;

  changeFirstName(FormWydnex<String> firstName) {
    state = state.copyWith(
      firstName: firstName,
    );
  }

  changeLastName(FormWydnex<String> lastName) {
    state = state.copyWith(
      lastName: lastName,
    );
  }

  changeEmail(FormWydnex<String> email) {
    state = state.copyWith(
      email: email,
    );
  }

  changePassword(FormWydnex<String> password) {
    state = state.copyWith(
      password: password,
    );
  }

  changePhone(FormWydnex<String> phone) {
    state = state.copyWith(
      phone: phone,
    );
  }

  changeDNI(FormWydnex<String> dni) {
    state = state.copyWith(
      dni: dni,
    );
  }

  changeRUC(FormWydnex<String> ruc) {
    state = state.copyWith(
      ruc: ruc,
    );
  }

  changeCode(FormWydnex<String> code) {
    state = state.copyWith(
      code: code,
    );
  }

  changeDate(FormWydnex<String> date) {
    state = state.copyWith(
      date: date,
    );
  }

  changeURL(FormWydnex<String> url) {
    state = state.copyWith(
      url: url,
    );
  }

  changeComment(FormWydnex<String> comment) {
    state = state.copyWith(
      comment: comment,
    );
  }
}

class InputsState {
  final FormWydnex<String> firstName;
  final FormWydnex<String> lastName;
  final FormWydnex<String> email;
  final FormWydnex<String> password;
  final FormWydnex<String> phone;
  final FormWydnex<String> dni;
  final FormWydnex<String> ruc;
  final FormWydnex<String> code;
  final FormWydnex<String> date;
  final FormWydnex<String> url;
  final FormWydnex<String> comment;

  InputsState({
    this.firstName = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.firstName],
    ),
    this.lastName = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.lastName],
    ),
    this.email = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.email],
    ),
    this.password = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.password],
    ),
    this.phone = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.phone],
    ),
    this.dni = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.dni],
    ),
    this.ruc = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.ruc],
    ),
    this.code = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.code],
    ),
    this.date = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.date],
    ),
    this.url = const FormWydnex(
      value: '',
      validators: [Validators.required, Validators.url],
    ),
    this.comment = const FormWydnex(
      value: '',
      validators: [],
    ),
  });

  InputsState copyWith({
    FormWydnex<String>? firstName,
    FormWydnex<String>? lastName,
    FormWydnex<String>? email,
    FormWydnex<String>? password,
    FormWydnex<String>? phone,
    FormWydnex<String>? dni,
    FormWydnex<String>? ruc,
    FormWydnex<String>? code,
    FormWydnex<String>? date,
    FormWydnex<String>? url,
    FormWydnex<String>? comment,
  }) {
    return InputsState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      dni: dni ?? this.dni,
      ruc: ruc ?? this.ruc,
      code: code ?? this.code,
      date: date ?? this.date,
      url: url ?? this.url,
      comment: comment ?? this.comment,
    );
  }
}
