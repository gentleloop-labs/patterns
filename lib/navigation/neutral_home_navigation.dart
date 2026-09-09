import 'package:flutter/foundation.dart';

/// Cross-platform signal used by completion flows to return the active shell
/// to its neutral Today/Home tab without rebuilding the app or losing data.
class NeutralHomeNavigation extends ChangeNotifier {
  int _requestCount = 0;

  int get requestCount => _requestCount;

  void request() {
    _requestCount++;
    notifyListeners();
  }
}

final neutralHomeNavigation = NeutralHomeNavigation();
