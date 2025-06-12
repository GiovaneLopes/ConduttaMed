import 'package:condutta_med/libs/src/utils/network_checker.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';
import 'package:condutta_med/libs/acls/datasource/acls_local_data_source.dart';
import 'package:condutta_med/libs/acls/datasource/acls_remote_data_source.dart';

abstract class AclsRespository {
  Future<void> saveSettings(AclsSettings settings, String? userId);
  Future<AclsSettings?> loadSettings(String? userId);
  Future<void> resetSettings(String? userId);
  Future<void> resetLocalSettings();
  Future<void> saveHistory(String? userId, List<AclsHistoryItem> list);
  Future<List<AclsHistoryItem>> loadHistory(String? userId);
  Future<void> clean();
}

class AclsRespositoryImpl implements AclsRespository {
  final AclsLocalDataSourceImpl localDataSource;
  final AclsRemoteDataSourceImpl remoteDataSource;

  AclsRespositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  @override
  Future<void> saveSettings(AclsSettings settings, String? userId) async {
    await localDataSource.saveSettings(settings);
    if (await NetworkChecker.isConnected() && userId != null) {
      remoteDataSource.saveSettings(settings, userId);
    }
  }

  @override
  Future<AclsSettings?> loadSettings(String? userId) async {
    final localSettings = await localDataSource.loadSettings();
    if (localSettings != null) {
      return localSettings;
    } else if (await NetworkChecker.isConnected() && userId != null) {
      final remoteSettings = await remoteDataSource.loadSettings(userId);
      if (remoteSettings != null) {
        await localDataSource.saveSettings(remoteSettings);
        return remoteSettings;
      }
    }
    return null;
  }

  @override
  Future<void> resetLocalSettings() async {
    await localDataSource.resetSettings();
  }

  @override
  Future<void> resetSettings(String? userId) async {
    await resetLocalSettings();
    if (await NetworkChecker.isConnected() && userId != null) {
      remoteDataSource.resetSettings(userId);
    }
  }

  @override
  Future<void> saveHistory(String? userId, List<AclsHistoryItem> list) async {
    await localDataSource.saveHistory(list);
    if (userId != null && await NetworkChecker.isConnected()) {
      await remoteDataSource.saveHistory(userId, list);
    }
  }

  @override
  Future<List<AclsHistoryItem>> loadHistory(String? userId) async {
    List<AclsHistoryItem> list = await localDataSource.loadHistory();
    if (list.isEmpty && userId != null && await NetworkChecker.isConnected()) {
      list = await remoteDataSource.loadHistory(userId);
      if (list.isNotEmpty) await localDataSource.saveHistory(list);
    }
    return list;
  }

  @override
  Future<void> clean() async {
    await localDataSource.clean();
  }
}
