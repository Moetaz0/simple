import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'LanguageTranslation.dart';
import 'TranslationsDelegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      localizationsDelegates: [
        TranslationsDelegate(), // Your custom translations delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onLocaleChange(Locale locale) async {
    setState(() {
      LanguageTranslation.load(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          LanguageTranslation.of(context)!.value('main_title'),
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              onLocaleChange(const Locale("ar"));
            },
            tooltip: 'تغيير اللغة إلى العربية', // Tooltip in Arabic
            child: Text('عربي'), // Button label in Arabic
          ),
          SizedBox(width: 8), // Adding some space between the buttons
          FloatingActionButton(
            onPressed: () {
              onLocaleChange(const Locale("en"));
            },
            tooltip:
                'Change Language to English', // Keep the tooltip in English
            child: Text('EN'), // Button label for English
          ),
        ],
      ),
    );
  }
}
