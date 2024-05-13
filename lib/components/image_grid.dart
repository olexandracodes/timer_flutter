import 'package:flutter/material.dart';
import 'package:timer_flutter/components/image_item.dart';
import 'package:timer_flutter/pages/settings_page.dart';


class ImageGrid extends StatefulWidget {
  final List<ImageObject>? itemsList;

  const ImageGrid({
    super.key,
    this.itemsList,
  });

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: responsiveCrossAxisCount(context),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.itemsList?.length ?? 0,
        itemBuilder: (context, index) {
          if (widget.itemsList != null && index < widget.itemsList!.length) {
            final product = widget.itemsList![index];
            return Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                
                
                child: ImageItem(imageItem: product, key: Key(product.imageId)),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  int responsiveCrossAxisCount(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 1371.0) {
      return 4;
    } else if (MediaQuery.of(context).size.width >= 768.0) {
      return 3;
    } else {
      return 1;
    }
  }
}