import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';

class AppCircularAvatar extends StatelessWidget {
  final ImageProvider? imageProvider;
  final String? networkImageUrl;
  final String? assetImagePath;
  final Widget? child;
  final double? width;
  final double? height;
  final double radius;
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

  // Background color when no image is available
  final Color? backgroundColor;

  final bool enableShadow;
  final BoxShadow? customShadow;

  const AppCircularAvatar({
    super.key,
    this.imageProvider,
    this.networkImageUrl,
    this.assetImagePath,
    this.child,
    this.width,
    this.height,
    this.radius = 50.0,
    this.borderColor,
    this.borderWidth = 0.0,
    this.isEditable = false,
    this.onEditPressed,
    this.editIconBackgroundColor,
    this.editIconColor,
    this.editIcon,
    this.editIconSize = 16.0,
    this.editButtonSize = 24.0,
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
            size: radius,
            color: AppColors.greyColor,
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
          width: width ?? (radius),
          height: height ?? (radius),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? AppColors.backgroundColor,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
            boxShadow: enableShadow
              ? [
                  customShadow ?? BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
          ),
          child: ClipOval(
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
                child: editIcon ?? Icon(
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