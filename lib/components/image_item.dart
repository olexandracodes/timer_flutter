import 'package:flutter/material.dart';
import 'package:timer_flutter/pages/settings_page.dart';
import 'package:timer_flutter/src/app_styles.dart';


class ImageItem extends StatelessWidget {
  final ImageObject imageItem;

  const ImageItem({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        
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
                  tag: imageItem.image,
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageItem.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      semanticLabel: imageItem.altDescription,
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
                        imageItem.longName!.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.appBlue,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                      child: Text(
                        '@${imageItem.user!.username}',
                        style: const TextStyle(
                          color: AppColors.appBlue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                      child: Text(
                        imageItem.user!.location,
                        style: const TextStyle(
                          color: AppColors.appBlue,
                        ),
                      ),
                    ),
                    if (imageItem.likes != 0)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: Text(
                          'Likes: ${imageItem.likes}',
                          style: const TextStyle(
                            color: AppColors.appBlue,
                          ),
                        ),
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