import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/libs/acls/models/acls_alert.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/acls/widgets/acls_help_content.dart';
import 'package:condutta_med/modules/shared/components/custom_dialog.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';
import 'package:condutta_med/modules/acls/widgets/acls_protocol_content.dart';
import 'package:condutta_med/modules/acls/widgets/acls_informations_content.dart';

class AclsPage extends StatefulWidget {
  const AclsPage({super.key});

  @override
  State<AclsPage> createState() => _AclsPageState();
}

class _AclsPageState extends State<AclsPage>
    with SingleTickerProviderStateMixin {
  final bloc = Modular.get<AclsCubit>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    bloc.initTimer();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.index = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInitialDialog();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  _showInitialDialog() {
    if (!mounted) return;
    if (bloc.state.settings.showInitialSuggestions) {
      showCustomDialog(
        context,
        confirmButtonLabel: 'Iniciar',
        onConfirm: Modular.to.pop,
        title: 'Medidas iniciais',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              '1- Chame ajuda!',
              style: AppTextStyles.bodyNormal,
            ),
            SizedBox(height: 12.h),
            Text(
              '2- Solicite o desfribilador/DEA.',
              style: AppTextStyles.bodyNormal,
            ),
            SizedBox(height: 12.h),
            Text(
              '3- Inicie a compressão torácica.',
              style: AppTextStyles.bodyNormal,
            ),
            SizedBox(height: 12.h),
            Text(
              '4- Solicite acesso venoso.',
              style: AppTextStyles.bodyNormal,
            ),
            SizedBox(height: 12.h),
            Text(
              '5- Cheque a glicemia.',
              style: AppTextStyles.bodyNormal,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AclsCubit, AclsState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.alert != null) {
          SnackbarWidget.mostrar(
            context,
            title: state.alert?.title,
            message: (state.alert == AclsAlert.eventoAdicionado)
                ? state.events.last
                : (state.alert == AclsAlert.outraMedicacaoAdicionada)
                    ? state.medications.last.name
                    : state.alert?.message,
            type: state.alert?.type,
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (value) async => false,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.w),
                  Text(
                    state.formatTime(state.totalTimer?.tick ?? 0),
                    style: AppTextStyles.titleBold.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TabBar(
                    controller: tabController,
                    indicatorColor: AppColors.secondary,
                    labelColor: AppColors.secondary,
                    unselectedLabelColor: AppColors.grey,
                    labelStyle: AppTextStyles.subtitleBold,
                    unselectedLabelStyle: AppTextStyles.subtitleBold,
                    dividerHeight: 0,
                    tabs: const [
                      Tab(text: 'Protocolo'),
                      Tab(text: 'Informações'),
                      Tab(text: 'Ajuda'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        AclsProtocolContent(),
                        AclsInformationsContent(),
                        AclsHelpContent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
