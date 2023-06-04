import 'package:shared_preferences/shared_preferences.dart';

enum InitialCheckStatus {
  enterLogin,
  enterSecurityCode,
  enterStashword,
  done,
  ;

  static InitialCheckStatus? fromString(String name) {
    for (var oneValue in InitialCheckStatus.values) {
      if (oneValue.name == name) {
        return oneValue;
      }
    }
    return null;
  }
}

class AcePref {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs != null ? _prefs! : throw StateError("Preferences not initialized");

  static Future<void> storeValue<T>(PrefKey<T> key, T value) async {
    if (value is String) {
      await prefs.setString(key.key, value);
    } else if (value is bool) {
      await prefs.setBool(key.key, value);
    } else if (value is int) {
      await prefs.setInt(key.key, value);
    } else if (value is double) {
      await prefs.setDouble(key.key, value);
    } else if (value is DateTime) {
      await prefs.setInt(key.key, value.millisecondsSinceEpoch);
    } else if (value is InitialCheckStatus) {
      await prefs.setString(key.key, value.name);
    } else {
      throw StateError("Unsupported value type: $T");
    }
  }

  static Future<void> removeValue<T>(PrefKey<T> key) async {
    await prefs.remove(key.key);
  }

  static T? getValue<T>(PrefKey<T> key) {
    if (T == String) {
      return prefs.getString(key.key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key.key) as T?;
    } else if (T == int) {
      return prefs.getInt(key.key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key.key) as T?;
    } else if (T == DateTime) {
      final intValue = prefs.getInt(key.key);
      if (intValue != null) {
        return DateTime.fromMillisecondsSinceEpoch(intValue) as T?;
      } else {
        return null;
      }
    } else if (T == InitialCheckStatus) {
      final strValue = prefs.getString(key.key);
      if (strValue != null) {
        return InitialCheckStatus.fromString(strValue) as T?;
      } else {
        return null;
      }
    } else {
      throw StateError("Unsupported value type: $T");
    }
  }

  static Future<void> clearAll() async {
    await prefs.clear();
  }
}

class PrefKey<T> {
  final String key;

  const PrefKey(this.key);

  static const lockAfter = PrefKey<int>('lock_after');
  static const lockTime = PrefKey<DateTime>('lock_time');
  static const lockOnExit = PrefKey<bool>('lock_on_exit');

  static const initialCheckStatus = PrefKey<InitialCheckStatus>('initial_check_status');

  static const paying = PrefKey<bool>('paying');
  static const validUntil = PrefKey<DateTime>('valid_until');

  static const touchIdIsOn = PrefKey<bool>('touch_id_is_on');

  static const lastSyncDate = PrefKey<DateTime>('last_sync_date');
  static const vaultLocked = PrefKey<bool>('vault_locked'); // client
  static const serverVaultLocked = PrefKey<bool>('server_vault_locked');

  static const numLaunches = PrefKey<int>('num_launches');
}
