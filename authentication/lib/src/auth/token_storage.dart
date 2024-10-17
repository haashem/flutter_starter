import 'dart:async';

abstract interface class TokenStorage<T> {
  Future<T?> load();
  Future<void> save(T tokenPair);
  Future<void> clear();

  Stream<T?> getStream();

  /// Closes the storage.
  ///
  /// After this method is called, the storage should not be used anymore.
  Future<void> close();
}

typedef Token = String;

abstract interface class Store<T> {
  Future<T?> get(String key);

  Future<void> set(String key, T value);

  Future<void> delete({required String key});
}

final class SecureTokenStorage implements TokenStorage<Token> {
  final Store<Token> _storage;
  final key = 'token';
  final StreamController<Token?> _controller = StreamController.broadcast();

  SecureTokenStorage(this._storage);

  @override
  Future<Token?> load() async {
    return _storage.get(key);
  }

  @override
  Future<void> save(Token token) async {
    await _storage.set(key, token);
    _controller.add(token);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: key);
    _controller.add(null);
  }

  @override
  Stream<Token?> getStream() => _controller.stream;

  @override
  Future<void> close() => _controller.close();
}
