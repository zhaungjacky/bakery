import 'package:go_router/go_router.dart';
import 'package:superstore/pages/auth/auth_gate.dart';

class AppAouter {
  static GoRouter router() => GoRouter(routes: [
        GoRoute(
          path: AuthGate.path(),
          builder: (context, state) => const AuthGate(),
          // path: AuthGate.route(),
          // builder: (context, state) => const AuthGate(),
        )
      ]);
}
