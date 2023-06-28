import 'package:Stashword/prefs/ace_shared_prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  tearDownAll(() async {
  });

  group('test all prefs', () {
    testWidgets('test all prefs', (WidgetTester tester) async {
      await tester.runAsync(() => AcePref.init());

      const lockAfter = 1234;
      final lockTime = DateTime.timestamp();
      const lockOnExit = true;
      const initialCheckStatus = InitialCheckStatus.enterSecurityCode;
      const paying = true;
      final validUntil = DateTime.timestamp();
      const touchIdIsOn = true;
      final lastSyncDate = DateTime.timestamp();
      const vaultLocked = true;
      const serverVaultLocked = true;
      const numLaunches = 42;

      await AcePref.storeValue(PrefKey.lockAfter, lockAfter);
      AcePref.storeValue(PrefKey.lockTime, lockTime);
      AcePref.storeValue(PrefKey.lockOnExit, lockOnExit);
      AcePref.storeValue(PrefKey.initialCheckStatus, initialCheckStatus);
      AcePref.storeValue(PrefKey.paying, paying);
      AcePref.storeValue(PrefKey.validUntil, validUntil);
      AcePref.storeValue(PrefKey.touchIdIsOn, touchIdIsOn);
      AcePref.storeValue(PrefKey.lastSyncDate, lastSyncDate);
      AcePref.storeValue(PrefKey.vaultLocked, vaultLocked);
      AcePref.storeValue(PrefKey.serverVaultLocked, serverVaultLocked);
      AcePref.storeValue(PrefKey.numLaunches, numLaunches);

      expect(AcePref.getValue(PrefKey.lockAfter), equals(lockAfter));
      expect(AcePref.getValue(PrefKey.lockTime)?.millisecondsSinceEpoch, equals(lockTime.millisecondsSinceEpoch));
      expect(AcePref.getValue(PrefKey.initialCheckStatus), equals(initialCheckStatus));
      expect(AcePref.getValue(PrefKey.paying), equals(paying));
      expect(AcePref.getValue(PrefKey.validUntil)?.millisecondsSinceEpoch, equals(validUntil.millisecondsSinceEpoch));
      expect(AcePref.getValue(PrefKey.touchIdIsOn), equals(touchIdIsOn));
      expect(AcePref.getValue(PrefKey.lastSyncDate)?.millisecondsSinceEpoch, equals(lastSyncDate.millisecondsSinceEpoch));
      expect(AcePref.getValue(PrefKey.vaultLocked), equals(vaultLocked));
      expect(AcePref.getValue(PrefKey.serverVaultLocked), equals(serverVaultLocked));
      expect(AcePref.getValue(PrefKey.numLaunches), equals(numLaunches));

      AcePref.removeValue(PrefKey.lockAfter);
      expect(AcePref.getValue(PrefKey.lockAfter), equals(null));

      expect(AcePref.getValue(PrefKey.lockTime), isNotNull);
      AcePref.clearAll();
      expect(AcePref.getValue(PrefKey.lockTime), isNull);
    });
  });
}