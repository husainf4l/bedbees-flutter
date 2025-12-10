import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Premium Button with soft shadows and glassmorphism
class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool isGlass;
  final IconData? icon;
  final bool isLoading;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 56,
    this.borderRadius,
    this.isGlass = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(28),
        boxShadow: AppColors.mediumShadow,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isGlass 
            ? Colors.white.withOpacity(0.3)
            : (backgroundColor ?? AppColors.black),
          foregroundColor: textColor ?? AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(28),
            side: isGlass 
              ? BorderSide(color: Colors.white.withOpacity(0.3), width: 1.5)
              : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: isLoading 
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: AppTextStyles.buttonLarge.copyWith(
                    color: textColor ?? AppColors.white,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

/// Premium Text Field with soft styling
class PremiumTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isGlass;

  const PremiumTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.isGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isGlass ? [] : AppColors.softShadow,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: AppTextStyles.bodyLarge.copyWith(
          color: isGlass ? AppColors.white : AppColors.darkGrey,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: isGlass 
              ? AppColors.white.withOpacity(0.6)
              : AppColors.lightGrey,
          ),
          prefixIcon: prefixIcon != null 
            ? Icon(
                prefixIcon,
                color: isGlass 
                  ? AppColors.white.withOpacity(0.8)
                  : AppColors.mediumGrey,
                size: 20,
              )
            : null,
          filled: true,
          fillColor: isGlass 
            ? Colors.white.withOpacity(0.2)
            : AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isGlass 
                ? Colors.white.withOpacity(0.3)
                : AppColors.lightGrey.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isGlass 
                ? Colors.white.withOpacity(0.3)
                : AppColors.lightGrey.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isGlass 
                ? AppColors.white
                : AppColors.gradientBlueStart,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}

/// Price Pill/Badge with glass effect
class PricePill extends StatelessWidget {
  final String price;
  final bool isGlass;

  const PricePill({
    super.key,
    required this.price,
    this.isGlass = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isGlass 
          ? Colors.white.withOpacity(0.3)
          : AppColors.primaryTeal,
        borderRadius: BorderRadius.circular(20),
        border: isGlass 
          ? Border.all(color: Colors.white.withOpacity(0.3), width: 1.5)
          : null,
        boxShadow: AppColors.softShadow,
      ),
      child: Text(
        price,
        style: AppTextStyles.buttonSmall.copyWith(
          color: isGlass ? AppColors.white : AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Rating Badge
class RatingBadge extends StatelessWidget {
  final double rating;
  final bool isGlass;

  const RatingBadge({
    super.key,
    required this.rating,
    this.isGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isGlass 
          ? Colors.white.withOpacity(0.3)
          : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: isGlass 
          ? Border.all(color: Colors.white.withOpacity(0.3), width: 1.5)
          : null,
        boxShadow: isGlass ? [] : AppColors.softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: isGlass ? AppColors.primaryYellow : AppColors.warning,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: AppTextStyles.caption.copyWith(
              color: isGlass ? AppColors.white : AppColors.darkGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
