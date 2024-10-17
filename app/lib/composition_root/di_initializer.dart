import 'package:authentication/authentication.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sky_store_starter/composition_root/dependencies_container.dart';

class DiInitializer {
  DiInitializer._();
  static Future<DependenciesContainer> initialize() async {
    const secureStorage = FlutterSecureStorage();

    return DependenciesContainer(store: SecureStore(secureStorage));
  }
}

class SecureStore implements Store<Token> {
  final FlutterSecureStorage secureStorage;
  SecureStore(this.secureStorage);

  @override
  Future<void> delete({required String key}) {
    return secureStorage.delete(key: key);
  }

  @override
  Future<Token?> get(String key) => secureStorage.read(key: key);

  @override
  Future<void> set(String key, Token value) =>
      secureStorage.write(key: key, value: value);
}
