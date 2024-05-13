import 'package:flutter/material.dart';
import 'package:timer_flutter/components/image_grid.dart';
import 'package:timer_flutter/components/loading_dialog.dart';
import 'package:timer_flutter/utils/fetch_from_unsplash.dart';
import 'package:timer_flutter/utils/localizations.dart';
import 'package:timer_flutter/src/app_styles.dart';

class ImageObject {
  final String imageId;
  final String image;
  final String? longName;
  final int? likes;
  final String? altDescription;
  final User? user;

  ImageObject({
    required this.imageId,
    required this.image,
    required this.longName,
    this.likes,
    String? altDescription,
    this.user,
  }) : altDescription = altDescription ?? '';
}

class User {
  final String username;
  final String name;
  final String bio;
  final String instagramUsername;
  final String location;

  User({
    required this.username,
    required this.name,
    required this.bio,
    required this.instagramUsername,
    required this.location,
  });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late S _localizations;
  late bool _isEnglish;
  late bool _isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ImageObject> unsplashItems = [];

  @override
  void initState() {
    super.initState();
    fetchUnsplashImageObjects().then((fetchedItems) {
      setState(() {
        unsplashItems = fetchedItems;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).welcome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                _isLoading
                    ? const CustomProgressDialog()
                    : ImageGrid(
                        itemsList: unsplashItems,
                      ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
