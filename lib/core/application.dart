import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_hoster/features/_common/presentation/router.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    initializeDateFormatting(S.delegate.supportedLocales.first.languageCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createAppRouter(),
      theme: appTheme.copyWith(textTheme: GoogleFonts.archivoTextTheme(appTheme.textTheme)),
      locale: S.delegate.supportedLocales.first,
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
    );
  }
}
