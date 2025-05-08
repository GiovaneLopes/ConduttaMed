import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brasil_fields/brasil_fields.dart';
import '../../shared/components/default_page.dart';
import '../../shared/components/solid_button.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/components/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/libs/user/model/user_model.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final bloc = Modular.get<AuthCubit>();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _celularController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  late DateTime _birthDate;

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      bloc.register(
        UserModel(
          name: _nomeController.text,
          email: _emailController.text,
          mobile: _celularController.text,
          cpf: _cpfController.text,
          password: _senhaController.text,
          birthDate: _birthDate,
        ),
      );
    }
  }

  String? _validateConfirmarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value != _senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dataNascimentoController.text =
            DateFormat('dd/MM/yyyy').format(picked);
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'Cadastro',
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Preencha seus dados para se cadastrar',
              style:
                  AppTextStyles.subtitleNormal.copyWith(color: AppColors.grey),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              labelText: 'Nome',
              controller: _nomeController,
              validator: AppValidators.validateNome,
              keyboardType: TextInputType.name,
            ),
            CustomTextFormField(
              labelText: 'E-mail',
              controller: _emailController,
              validator: AppValidators.validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              labelText: 'Data de nascimento',
              controller: _dataNascimentoController,
              readOnly: true,
              onTap: () => _selectDate(context),
              validator: AppValidators.validateDataNascimento,
              keyboardType: TextInputType.datetime,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            CustomTextFormField(
              labelText: 'Celular',
              controller: _celularController,
              validator: AppValidators.validateCelular,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            CustomTextFormField(
              labelText: 'CPF',
              controller: _cpfController,
              validator: AppValidators.validateCPF,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
            ),
            CustomTextFormField(
              labelText: 'Senha',
              controller: _senhaController,
              validator: AppValidators.validateSenha,
              obscureText: true,
            ),
            CustomTextFormField(
              labelText: 'Confirme a senha',
              controller: _confirmarSenhaController,
              validator: _validateConfirmarSenha,
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.error) {
                    SnackbarWidget.mostrar(context,
                        title: state.error?.title,
                        message: state.error?.message);
                  }
                },
                bloc: bloc,
                builder: (context, state) {
                  return SolidButton(
                    loading: state.status == AuthStatus.loading,
                    text: 'Cadastrar',
                    onPressed: _cadastrar,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
