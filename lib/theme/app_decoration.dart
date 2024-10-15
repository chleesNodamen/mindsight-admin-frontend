import 'package:mindsight_admin_page/app_export.dart';

class AppDecoration {
  /*
      fill
  */
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillWhite => BoxDecoration(
        color: appTheme.white,
      );

  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black,
      );

  static BoxDecoration get fillBackground => BoxDecoration(
        color: appTheme.background,
      );

  static BoxDecoration get fillGrayScale1 => BoxDecoration(
        color: appTheme.grayScale1,
      );

  static BoxDecoration get fillGrayScale2 => BoxDecoration(
        color: appTheme.grayScale2,
      );

  static BoxDecoration get fillGrayScale3 => BoxDecoration(
        color: appTheme.grayScale3,
      );

  static BoxDecoration get fillGrayScale8 => BoxDecoration(
        color: appTheme.grayScale8,
      );

  static BoxDecoration get fillSkyBlue => BoxDecoration(
        color: appTheme.skyBlue,
      );

  /*
      outline
  */
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.white,
        border: Border.all(
          color: appTheme.grayScale2,
          width: 1,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder12,
      );

  /*
      gradient
  */
  static BoxDecoration get gradientPrimaryToPrimary => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0.12),
          end: const Alignment(0.5, 0.83),
          colors: [
            theme.colorScheme.primary.withOpacity(0),
            theme.colorScheme.primary,
          ],
        ),
      );
  static BoxDecoration get gradientBlackToBlack => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [
            appTheme.black.withOpacity(0),
            appTheme.black,
          ],
        ),
      );
  static BoxDecoration get gradientWhiteToWhite => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [
            appTheme.white.withOpacity(0),
            appTheme.white,
          ],
        ),
      );

  static BoxDecoration get gradientWhiteToBackg => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.00, -0.20),
          end: const Alignment(0, 1),
          colors: [
            appTheme.white,
            appTheme.background.withOpacity(0),
          ],
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius get roundedBorder6 => BorderRadius.circular(
        6,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8,
      );
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20,
      );
  static BorderRadius get roundedBorder32 => BorderRadius.circular(
        32,
      );
  static BorderRadius get roundedBorder64 => BorderRadius.circular(
        64,
      );
  static BorderRadius get roundedBorder140 => BorderRadius.circular(
        140,
      );
}
