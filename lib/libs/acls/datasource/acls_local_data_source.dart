import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';

abstract class AclsLocalDataSource {
  Future<void> saveSettings(AclsSettings settings);
  Future<AclsSettings?> loadSettings();
  Future<void> resetSettings();
  Future<void> saveHistory(List<AclsHistoryItem> list);
  Future<List<AclsHistoryItem>> loadHistory();
  Future<void> clean();
}

class AclsLocalDataSourceImpl extends AclsLocalDataSource {
  AclsLocalDataSourceImpl() {
    init();
  }
  late SharedPreferences instance;
  static const String _settingsKey = 'appSettings';

  Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveSettings(AclsSettings settings) async {
    final settingsMap = settings.toJson();
    await instance.setString(_settingsKey, jsonEncode(settingsMap));
  }

  @override
  Future<AclsSettings?> loadSettings() async {
    final settingsString = instance.getString(_settingsKey);
    if (settingsString != null) {
      return AclsSettings.fromJson(jsonDecode(settingsString));
    }
    return null;
  }

  @override
  Future<void> resetSettings() async {
    await instance.remove(_settingsKey);
  }

  @override
  Future<void> saveHistory(List<AclsHistoryItem> list) async {
    final historyString = jsonEncode(list);
    await instance.setString('aclsHistory', historyString);
  }

  @override
  Future<List<AclsHistoryItem>> loadHistory() async {
    final historyString = instance.getString('aclsHistory');
    if (historyString != null) {
      final List<dynamic> historyList = jsonDecode(historyString);
      return historyList.map((item) => AclsHistoryItem.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<void> clean() async {
    await instance.clear();
  }
}
