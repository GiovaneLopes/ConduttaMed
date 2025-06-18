import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/utils/app_pdf.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';
import 'package:condutta_med/modules/acls/bloc/acls_history/acls_history_cubit.dart';

class AclsPdfCreator {
  static Future<File> generate(AclsHistoryItem item) async {
    final pdf = pw.Document();
    String nomeArquivo = "Proto Saúde - ${item.id}";
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [_getPdf()],
      ),
    );
    return AppPdf.saveDocument(
        name: _converterDataParaNomeArquivo(nomeArquivo), pdf: pdf);
  }

  static String _converterDataParaNomeArquivo(String data) {
    return data.replaceAll('/', '_').replaceAll(' - ', ' ');
  }

  static pw.Widget _getPdf() {
    final bloc = Modular.get<AclsHistoryCubit>();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
          decoration: const pw.BoxDecoration(color: PdfColors.blue700),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                  'ACLS: ${bloc.state.getFormattedDateWithTime(bloc.state.selected?.date ?? DateTime.now())}',
                  style: const pw.TextStyle(color: PdfColors.white)),
            ],
          ),
        ),
        pw.SizedBox(height: 13.h),
        pw.Text(
          'Resumo',
          style: const pw.TextStyle(color: PdfColors.grey),
        ),
        getInfoLine(
          title: 'Tempo total',
          value: bloc.state.formatTime(
            (bloc.state.selected?.duration ?? 0),
          ),
        ),
        getInfoLine(
          title: 'FCT',
          value: '${bloc.state.selected?.fct ?? 0}%',
        ),
        getInfoLine(
          title: 'Ciclos de compressão',
          value: bloc.state.selected?.totalCompressions.toString() ?? '',
        ),
        getInfoLine(
          title: 'Choques',
          value: bloc.state.selected?.totalShocks.toString() ?? '',
        ),
        getInfoLine(
          title: 'Adrenalinas',
          value: bloc.state.selected?.totalAdrenalines.toString() ?? '',
        ),
        getInfoLine(
          title: 'Medicações',
          value: bloc.state.selected?.totalMedications.toString() ?? '',
        ),
        getInfoLine(
          title: 'Tempo total de compressão',
          value: bloc.state
              .formatTime((bloc.state.selected?.totalCompressionsTime ?? 0)),
        ),
        pw.SizedBox(height: 24.h),
        pw.Text(
          'Registros',
          style: const pw.TextStyle(color: PdfColors.grey),
        ),
        ...bloc.state.selected!.activities.map((activity) {
          return getInfoLine(
            title: activity.title,
            value: activity.time,
          );
        })
      ],
    );
  }

  static pw.Widget getInfoLine({
    required String title,
    required String value,
    PdfColor valueColor = PdfColors.black,
  }) {
    return pw.Container(
      padding: pw.EdgeInsets.symmetric(vertical: 8.h),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            title,
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
