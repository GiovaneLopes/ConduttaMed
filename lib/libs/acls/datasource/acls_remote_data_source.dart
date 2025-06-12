import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';
import 'package:condutta_med/libs/src/exceptions/generic_errors.dart';

abstract class AclsRemoteDataSource {
  Future<void> saveSettings(AclsSettings settings, String userId);
  Future<AclsSettings?> loadSettings(String userId);
  Future<void> resetSettings(String userId);
  Future<List<AclsHistoryItem>> loadHistory(String userId);
  Future<void> saveHistory(String userId, List<AclsHistoryItem> list);
}

class AclsRemoteDataSourceImpl implements AclsRemoteDataSource {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<T> _safeCall<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<void> saveSettings(AclsSettings settings, String userId) async {
    await _safeCall(() async {
      final ref = _db.ref('settings/acls/').child(userId);
      await ref.set(settings.toJson());
    });
  }

  @override
  Future<AclsSettings?> loadSettings(String userId) async {
    return await _safeCall(() async {
      final ref = _db.ref('settings/acls/').child(userId);
      final response = await ref.get();
      if (response.exists) {
        final settingsData =
            Map<String, dynamic>.from(jsonDecode(jsonEncode(response.value)));
        return AclsSettings.fromJson(settingsData);
      } else {
        return null;
      }
    });
  }

  @override
  Future<void> resetSettings(String userId) async {
    return await _safeCall(() async {
      final ref = _db.ref('settings/acls/').child(userId);
      await ref.remove();
    });
  }

  @override
  Future<List<AclsHistoryItem>> loadHistory(String userId) async {
    return await _safeCall(
      () async {
        final ref = _db.ref('history/acls/').child(userId);
        final response = await ref.get();
        if (response.exists) {
          final historyList = List<Map<String, dynamic>>.from(
              jsonDecode(jsonEncode(response.value)));
          return historyList
              .map((item) => AclsHistoryItem.fromJson(item))
              .toList();
        } else {
          return <AclsHistoryItem>[];
        }
      },
    );
  }

  @override
  Future<void> saveHistory(String userId, List<AclsHistoryItem> list) async {
    return await _safeCall(() async {
      final ref = _db.ref('history/acls/').child(userId);
      List<Map<String, dynamic>> updates = list.map((p) => p.toJson()).toList();
      await ref.set(updates);
    });
  }
}
