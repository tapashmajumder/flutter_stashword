import 'package:Stashword/network/network_operation.dart';
import 'package:Stashword/network/server_jsons.dart';
import 'package:Stashword/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerViewModelProvider = Provider.autoDispose<RegisterViewModel>((ref) => RegisterViewModel(ref: ref));

class RegisterViewModel {
  final ProviderRef<RegisterViewModel> ref;
  final existsProvider = StateProvider<bool?>((ref) => null);

  RegisterViewModel({required this.ref});

  void onSendAuthorizationCode(String email) async {
    final jsonOperation = NetworkOperation(
      requestMethod: RequestMethod.post,
      server: "api2.stashword.com",
      path: "/app/login",
    );
    jsonOperation.headers = {
      HeaderParam.login: email,
    };

    LoginResult result = await jsonOperation.fetchResult(fromJson: LoginResult.fromJson);
    ref.read(existsProvider.notifier).state = result.exists;
  }

  void onConfirmCreateNewUser() {
    ref.read(providers.showDialogProvider.notifier).state = DialogType.confirm;
  }

  void onUserExists() {
    ref.read(providers.showDialogProvider.notifier).state = DialogType.confirm;
  }
}