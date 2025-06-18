import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';
import 'package:condutta_med/modules/shared/utils/acls_pdf_creator.dart';

class AppPdf {
  static Future<File> generatePdf(AclsHistoryItem item) async {
    return await AclsPdfCreator.generate(item);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
