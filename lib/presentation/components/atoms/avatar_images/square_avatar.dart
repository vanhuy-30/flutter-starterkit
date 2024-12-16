import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';

class SquareAvatar extends StatelessWidget {

  final ImageProvider? imageProvider;
  final String? networkImageUrl;
  final String? assetImagePath;
  final Widget? child;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;

  final bool isEditable;
  final VoidCallback? onEditPressed;
  final Color? editIconBackgroundColor;
  final Color? editIconColor;
  final Widget? editIcon;
  final double? editIconSize;
  final double? editButtonSize;

  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? backgroundColor;

  final bool enableShadow;
  final BoxShadow? customShadow;

  const SquareAvatar({
    super.key,
    this.imageProvider,
    this.networkImageUrl,
    this.assetImagePath,
    this.child,
    this.width,
    this.height,
    this.borderRadius = 10.0,
    this.borderColor,
    this.editIcon,
    this.editIconSize = 16.0,
    this.editButtonSize = 24.0,
    this.borderWidth = 0.0,
    this.isEditable = false,
    this.onEditPressed,
    this.editIconBackgroundColor,
    this.editIconColor,
    this.placeholder,
    this.errorWidget,
    this.backgroundColor,
    this.enableShadow = false,
    this.customShadow,
  });

  ImageProvider? _getImageProvider() {
    if (imageProvider != null) return imageProvider;
    if (networkImageUrl != null) return NetworkImage(networkImageUrl!);
    if (assetImagePath != null) return AssetImage(assetImagePath!);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _getImageProvider();
    
    Widget avatarContent = child ?? Container();

    if (imageProvider != null) {
      avatarContent = Image(
        image: imageProvider,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? Icon(
            Icons.person, 
            size: width ?? 50,
            color: Colors.grey,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
          );
        },
      );
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: width ?? 50,
          height: height ?? 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor ?? Colors.grey[200],
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
            boxShadow: enableShadow
              ? [
                  customShadow ?? BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: avatarContent,
          ),
        ),
        if (isEditable)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: editButtonSize,
                height: editButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: editIconBackgroundColor ?? AppColors.primaryColor,
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.edit,
                  size: editIconSize,
                  color: editIconColor ?? AppColors.whiteColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
