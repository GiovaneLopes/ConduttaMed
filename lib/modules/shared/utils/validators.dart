import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';

class AppValidators {
  static String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 3) {
      return 'Nome deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? validateDataNascimento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    try {
      DateFormat('dd/MM/yyyy').parseStrict(value);
    } catch (e) {
      return 'Data de nascimento inválida (dd/MM/yyyy)';
    }
    return null;
  }

  static String? validateCelular(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 14) {
      // Considerando a máscara do BrasilFields
      return 'Celular inválido';
    }
    return null;
  }

  static String? validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedValue.length != 11 || !CPFValidator.isValid(cleanedValue)) {
      return 'CPF inválido';
    }
    return null;
  }

  static String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }
}
