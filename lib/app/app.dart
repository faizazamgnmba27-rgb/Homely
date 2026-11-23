import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/homely_theme.dart';
import 'theme/homely_theme_provider.dart';

class HomelyApp extends ConsumerWidget {
  const HomelyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'HOMELY',
      debugShowCheckedModeBanner: false,
      routerConfig: homelyRouter,
      themeMode: themeMode,
      theme: HomelyTheme.lightTheme,
      darkTheme: HomelyTheme.darkTheme,
    );
  }
}
