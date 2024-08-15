import 'package:go_router/go_router.dart';
import 'package:superstore/pages/auth/auth_gate.dart';
import 'package:superstore/pages/speech-to-text/speech_to_text.dart';
import 'package:superstore/pages/tags/tags_page.dart';

class AppAouter {
  static GoRouter router() => GoRouter(
        initialLocation: AuthGate.routhPath(),
        routes: [
          GoRoute(
            path: AuthGate.routhPath(),
            builder: (context, state) => const AuthGate(),
            // path: AuthGate.route(),
            // builder: (context, state) => const AuthGate(),
          ),
          GoRoute(
            path: TagsPage.routhPath(),
            builder: (context, state) => const TagsPage(),
            // path: AuthGate.route(),
            // builder: (context, state) => const AuthGate(),
          ),
          GoRoute(
            path: SpeechToText.routhPath(),
            builder: (context, state) => const SpeechToText(),
          ),
        ],
      );
}
