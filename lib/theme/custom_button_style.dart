import 'package:mindsight_admin_page/app_export.dart';

class CustomButtonStyles {
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: appTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      );

  static ButtonStyle get fillPrimaryTransparent => ElevatedButton.styleFrom(
        backgroundColor: appTheme.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      );

  static ButtonStyle get fillWhite => ElevatedButton.styleFrom(
        backgroundColor: appTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      );

  static ButtonStyle get fillTransparent => ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      );

  static ButtonStyle get fillBackground => ElevatedButton.styleFrom(
        backgroundColor: appTheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      );

  static ButtonStyle get fillRedTransparent => ElevatedButton.styleFrom(
        backgroundColor: appTheme.red.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      );

    static ButtonStyle get numberFillPrimary => ElevatedButton.styleFrom(
        backgroundColor: appTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      );

    static ButtonStyle get numberFillPrimaryTransparent => ElevatedButton.styleFrom(
        backgroundColor: appTheme.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      );
}
