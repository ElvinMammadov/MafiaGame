import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.startsWith('http') || this.startsWith("https")) {
      return ImageType.network;
    } else if (this.endsWith(".svg")) {
      return ImageType.svg;
    } else if (this.startsWith("file://")) {
      return ImageType.file;
    } else {
      ImageType.png;
    }
    return ImageType.unknown;
  }
}

enum ImageType { svg, png, network, file, unknown }

class CustomImageView extends StatelessWidget {
  CustomImageView(
      {required this.imagePath,
      this.height,
      this.width,
      this.color,
      this.fit,
      this.alignment,
      this.onTap,
      this.radius,
      this.margin,
      this.border,
      this.placeHolder = 'assets/images/image_not_found.png',
      this.gap = 8});

  String imagePath;
  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;
  double gap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

 Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: Padding(
          padding: EdgeInsets.all(gap),
          child: ClipRRect(
            borderRadius: radius?.subtract(BorderRadius.circular(gap)) ?? BorderRadius.zero,
            child: _buildImageView(),
          ),
        ),
      );
    } else {
      return _buildImageView();
    }
  }

  _buildImageView() {
    switch (imagePath.imageType) {
      case ImageType.svg:
        return Container(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: this.color != null
                ? ColorFilter.mode(
                    this.color ?? Colors.transparent, BlendMode.srcIn)
                : null,
          ),
        );
      case ImageType.file:
        return Image.file(
          File(imagePath),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: imagePath,
          height: height,
          width: width,
          fit: fit,
          color: color,
          placeholder: (context, url) => Container(
            height: 30,
            width: 30,
            child: LinearProgressIndicator(
              color: Colors.grey.shade200,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            placeHolder,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        );
      case ImageType.png:
      default:
        return Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}
