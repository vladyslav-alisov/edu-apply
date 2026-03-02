import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';

class StyledCachedNetworkImage extends StatelessWidget {
  const StyledCachedNetworkImage({
    super.key,
    required double imageSize,
    required String imageUrl,
    required Widget Function(BuildContext context, ImageProvider imageProvider)
        builder,
  })  : _imageSize = imageSize,
        _imageUrl = imageUrl,
        _builder = builder;

  final double _imageSize;
  final String _imageUrl;
  final Widget Function(BuildContext context, ImageProvider imageProvider)
      _builder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _imageUrl,
      imageBuilder: _builder,
      placeholder: (context, url) => SizedBox(
        width: _imageSize,
        height: _imageSize,
        child: StyledLoadingIndicator(),
      ),
      errorListener: (value) {
        debugPrint(value.toString());
      },
      errorWidget: (context, url, error) => SizedBox(
        width: _imageSize,
        height: _imageSize,
        child: Center(
          child: Icon(
            Icons.error_outline,
          ),
        ),
      ),
    );
  }
}
