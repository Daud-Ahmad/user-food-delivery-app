import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CHINetworkImage extends StatelessWidget {
  final String? imageURL;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CHINetworkImage(this.imageURL,
      {Key? key, this.height = 40, this.width = 40, this.fit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL ?? 'https://cdn-icons-png.flaticon.com/512/1159/1159671.png',
      height: height!,
      width: width!,
      fit: fit,
      placeholder: (context, url) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'assets/no_image.png',
          height: height!,
          width: width,
          fit: BoxFit.contain,
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'assets/no_image.png',
          height: height!,
          width: width,
          fit: BoxFit.contain,
        ),
      ),
    );

    // return FadeInImage.assetNetwork(
    //   placeholder: 'assets/no_image.png',
    //   image: imageURL ?? 'https://www.bastiaanmulder.nl/wp-content/uploads/2013/11/dummy-image-square.jpg',
    //   height: height!,
    //   width: width!,
    //   fit: fit,
    //   imageErrorBuilder: (context, error, stackTrace) => Image.asset(
    //     'assets/no_image.png',
    //     height: height!,
    //     width: width!,
    //     fit: fit,
    //   ),
    // );
  }
}
