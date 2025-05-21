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
import 'package:condutta_med/modules/profile/bloc/profile_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bloc = Modular.get<ProfileCubit>();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _celularController = TextEditingController();
  final _cpfController = TextEditingController();
  late DateTime _birthDate;

  void _salvar() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        id: bloc.state.user?.id,
        name: _nomeController.text,
        email: _emailController.text,
        mobile: _celularController.text,
        cpf: _cpfController.text,
        birthDate: _birthDate,
      );
      if (user != bloc.state.user) bloc.update(user);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bloc.state.user?.birthDate ?? DateTime.now(),
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
      title: 'Meus dados',
      body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStatus.loaded) {
              _nomeController.text = bloc.state.user?.name ?? '';
              _emailController.text = bloc.state.user?.email ?? '';
              _dataNascimentoController.text = bloc.state.user?.birthDate !=
                      null
                  ? DateFormat('dd/MM/yyyy').format(bloc.state.user!.birthDate!)
                  : '';
              _celularController.text = bloc.state.user?.mobile ?? '';
              _cpfController.text = bloc.state.user?.cpf ?? '';
              _birthDate = bloc.state.user?.birthDate ?? DateTime.now();
            } else if (state.status == ProfileStatus.updated) {
              SnackbarWidget.mostrar(
                context,
                title: 'Usuário salvo',
                message: 'Seus dados foram salvos com sucesso',
                type: SnackbarWidgetType.success,
              );
            } else if (state.status == ProfileStatus.error) {
              SnackbarWidget.mostrar(context,
                  title: state.error?.title, message: state.error?.message);
            }
          },
          bloc: bloc,
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Preencha os campos abaixo para atualizar seus dados',
                    style: AppTextStyles.subtitleNormal
                        .copyWith(color: AppColors.grey),
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
                    readOnly: true,
                    enabled: false,
                    validator: AppValidators.validateCPF,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  SolidButton(
                    loading: state.status == ProfileStatus.loading,
                    label: 'Salvar',
                    onPressed: _salvar,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
