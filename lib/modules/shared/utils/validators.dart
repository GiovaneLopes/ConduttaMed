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
      final date = DateFormat('dd/MM/yyyy').parse(value);
      final today = DateTime.now();
      final age = today.year - date.year;

      if (age < 16 ||
          (age == 16 && today.isBefore(date.add(Duration(days: 365 * age))))) {
        return 'Você deve ter pelo menos 16 anos.';
      }
    } catch (e) {
      return 'Data de nascimento inválida.';
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

  static String? validateLoginSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 8) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve conter pelo menos uma letra maiúscula';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'A senha deve conter pelo menos um número';
    }
    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'A senha deve conter pelo menos um caractere especial';
    }
    return null;
  }
}
