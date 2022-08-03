import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';

class AuthConfig {
  Future<bool> podeAutenticar() async {
    final LocalAuthentication auth = LocalAuthentication();

    final bool podeAutenticarComBiometria = await auth.canCheckBiometrics;
    final bool podeAutenticar =
        podeAutenticarComBiometria || await auth.isDeviceSupported();

    return podeAutenticar;
  }

  Future<bool> autenticar() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Desbloqueie seu celular',
          authMessages: [
            const AndroidAuthMessages(
                biometricHint: 'Verifique sua identidade',
                signInTitle: 'Autenticação necessária',
                cancelButton: 'Cancelar')
          ],
          options: const AuthenticationOptions(
              useErrorDialogs: false, biometricOnly: true));

      return didAuthenticate;
      // ···
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.notEnrolled) {
        // ...
      } else {
        // ...
      }
      return false;
    }
  }
}
