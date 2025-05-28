import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/libs/acls/models/acls_alert.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/acls/widgets/acls_help_content.dart';
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
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.index = 0;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.w),
              Text(
                state.formatTime(state.totalTimer?.tick),
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
        );
      },
    );
  }
}
