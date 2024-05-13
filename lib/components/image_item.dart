import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/link.dart';
import 'package:timer_flutter/pages/settings_page.dart';
import 'package:timer_flutter/src/app_styles.dart';

class ImageItem extends StatefulWidget {
  final ImageObject imageItem;

  const ImageItem({Key? key, required this.imageItem}) : super(key: key);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  late int _rating = 0;

  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rating = prefs.getInt(widget.imageItem.imageId) ?? 0;
    });
  }

  Future<void> _saveRating(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.imageItem.imageId, rating);
    setState(() {
      _rating = rating;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => setState(() {}),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.appSecondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 30,
                color: Color.fromARGB(101, 146, 129, 99),
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: widget.imageItem.image,
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageItem.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      semanticLabel: widget.imageItem.altDescription,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 8, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                      child: Text(
                        widget.imageItem.longName!.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.appBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                      child: Text(
                        '@${widget.imageItem.user!.username}',
                        style: const TextStyle(
                          color: AppColors.appBlue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                      child: Text(
                        widget.imageItem.user!.location,
                        style: const TextStyle(
                          color: AppColors.appBlue,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(4, (index) {
                        final isSelected = index < _rating;
                        return GestureDetector(
                          onTap: () => _saveRating(index + 1),
                          child: Icon(
                            isSelected ? Icons.star : Icons.star_border,
                            color: isSelected ? AppColors.appOrange : null,
                          ),
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Link(
                          uri: Uri.parse(
                              'https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7'),
                          target: LinkTarget.blank,
                          builder: (BuildContext ctx, FollowLink? openLink) {
                            return TextButton.icon(
                              onPressed: openLink,
                              label: const Text(''),
                              icon: const Icon(Icons.share,
                                  color: AppColors.appBlue),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
