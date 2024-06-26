import 'package:mindsight_admin_page/app_export.dart';

// ignore: must_be_immutable
class PageLoadingIndicator extends StatefulWidget {
  PageLoadingIndicator(
      {super.key, required this.isLoading, required this.child});

  bool isLoading;
  final Widget child;

  @override
  State<PageLoadingIndicator> createState() => _PageLoadingIndicatorState();
}

class _PageLoadingIndicatorState extends State<PageLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Visibility(
          visible: widget.isLoading,
          child: Opacity(
            opacity: 0,
            child: Container(
                color: appTheme.white,
                width: double.infinity,
                height: double.infinity),
          ),
        ),
        Visibility(
          visible: widget.isLoading,
          child: Center(
            child: SizedBox(
                width: 100.adaptSize,
                height: 100.adaptSize,
                child: const CircularProgressIndicator(strokeWidth: 10,)),
          ),
        ),
      ],
    );
  }
}
