import 'package:flutter/material.dart';
import 'package:timer_flutter/data/localizations.dart';
import 'package:timer_flutter/src/app_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late S _localizations;
  late bool _isEnglish;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = S.of(context);
    _isEnglish = S.currentLocalization == 'en';
  }

  void _updateLocalization(Locale locale) async {
    await _localizations.load(locale);
    setState(() {
      _isEnglish = locale.languageCode == 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        bottomOpacity: 0,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        title: Text(S.of(context).hello),
        actions: [
          IconButton(
            onPressed: () {
              _updateLocalization(
                  _isEnglish ? const Locale('de') : const Locale('en'));
            },
            icon: _isEnglish
                ? const Text('🇩🇪', style: TextStyle(fontSize: 32))
                : const Text('🇬🇧', style: TextStyle(fontSize: 32)),
            hoverColor: _isEnglish ? AppColors.appBlue : AppColors.appOrange,
            iconSize: 50,
            padding: const EdgeInsets.all(0),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).welcome,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                child: Text(S.of(context).hello),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
