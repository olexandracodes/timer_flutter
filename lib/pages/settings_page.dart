import 'package:flutter/material.dart';
import 'package:timer_flutter/data/localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late S _localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).hello),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).german),
                    Switch(
                      value: S.currentLocalization == 'en',
                      onChanged: (value) {
                        setState(() {
                          if (value) {
                            _localizations.load(const Locale('en'));
                          } else {
                            _localizations.load(const Locale('de'));
                          }
                        });
                      },
                    ),
                    Text(S.of(context).english),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
