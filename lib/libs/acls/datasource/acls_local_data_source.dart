import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';

abstract class AclsLocalDataSource {
  Future<void> saveSettings(AclsSettings settings);
  Future<AclsSettings?> loadSettings();
  Future<void> resetSettings();
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
}
