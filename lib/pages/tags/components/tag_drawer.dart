import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore/pages/auth/auth_gate.dart';
import 'package:superstore/pages/speech-to-text/speech_to_text.dart';
import 'package:superstore/pages/tags/tags_page.dart';
import 'package:superstore/services/auth/repo/auth_repo.dart';
import 'package:superstore/services/singleton/singleton.dart';

class TagDrawer extends StatelessWidget {
  const TagDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                const Gap(16),
                const Icon(
                  Icons.barcode_reader,
                  size: 60,
                ),
                const Gap(16),
                Text(
                  "Tag Info",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown.shade400,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          const GoToStockMapTile(),
          const Gap(16),
          const GoToSpeechToTextTile(),
          const Gap(24),
          const Spacer(),
          const Divider(),
          const LogoutTile(),
          // const Gap(24),
        ],
      ),
    );
  }
}

class GoToStockMapTile extends StatelessWidget {
  const GoToStockMapTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.navigation_rounded,
        color: Colors.green,
      ),
      title: const Text("Stock Map"),
      onTap: () {
        context.go(AuthGate.routhPath());
      },
    );
  }
}

class LogoutTile extends StatelessWidget {
  const LogoutTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: const Text("Logout"),
      onTap: () async {
        await singleton<AuthRepository>().logout();
      },
    );
  }
}

class GoToSpeechToTextTile extends StatelessWidget {
  const GoToSpeechToTextTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.voice_chat,
        color: Colors.blue.shade400,
      ),
      title: const Text("Go To Speech"),
      onTap: () {
        context.push(SpeechToText.routhPath());
      },
    );
  }
}

class GoToTagsTile extends StatelessWidget {
  const GoToTagsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          Icons.barcode_reader,
          color: Colors.brown.shade400,
        ),
        title: const Text("Goto Tags"),
        onTap: () {
          context.push(TagsPage.routhPath());
        });
  }
}
