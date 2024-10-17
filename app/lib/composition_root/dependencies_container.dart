import 'package:authentication/authentication.dart';

class DependenciesContainer {
  final Store<Token> store;

  const DependenciesContainer({
    required this.store,
  });
}
