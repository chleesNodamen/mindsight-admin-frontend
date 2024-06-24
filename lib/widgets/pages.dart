import 'package:mindsight_admin_page/app_export.dart';

typedef NewPage = void Function(
  int pageNum,
);

class Pages extends StatelessWidget {
  final int pages;
  final int activePage;
  final NewPage onTap;

  const Pages(
      {super.key,
      required this.pages,
      required this.activePage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
          child: CustomImageView(
            imagePath: IconConstant.firstPage,
            width: 24,
            height: 24,
          ),
          onTap: () {
            if (activePage == 1) {
              return;
            } else {
              onTap(1);
            }
          }),
      const SizedBox(
        width: 8,
      ),
      GestureDetector(
          child: CustomImageView(
            imagePath: IconConstant.previousPage,
            width: 24,
            height: 24,
          ),
          onTap: () {
            if (activePage == 1) {
              return;
            } else {
              onTap(activePage - 1);
            }
          }),
      const SizedBox(
        width: 8,
      ),
      pages <= 6
          ? Wrap(
              runSpacing: 8,
              children: List.generate(pages, (index) {
                return CustomElevatedButton(
                  text: '${index + 1}',
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 31,
                  height: 30,
                  buttonStyle: (index + 1) == activePage
                      ? CustomButtonStyles.numberFillPrimary
                      : CustomButtonStyles.numberFillPrimaryTransparent,
                  buttonTextStyle: (index + 1) == activePage
                      ? CustomTextStyles.labelLargeWhite
                      : CustomTextStyles.labelLargeBlack,
                  onPressed: () {
                    onTap(index + 1);
                  },
                );
              }),
            )
          : Row(
              children: [
                activePage == 1
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          CustomElevatedButton(
                            text: '1',
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 31,
                            height: 30,
                            buttonStyle:
                                CustomButtonStyles.numberFillPrimaryTransparent,
                            buttonTextStyle: CustomTextStyles.labelLargeBlack,
                            onPressed: () => onTap(1),
                          ),
                          Visibility(
                            visible: activePage != 2,
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: IconConstant.more,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                (pages - activePage) < 5
                    ? Wrap(
                        runSpacing: 8,
                        children: List.generate(5, (index) {
                          return CustomElevatedButton(
                            text: '${index + pages - 4}',
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 31,
                            height: 30,
                            buttonStyle: (index + pages - 4) == activePage
                                ? CustomButtonStyles.numberFillPrimary
                                : CustomButtonStyles
                                    .numberFillPrimaryTransparent,
                            buttonTextStyle: (index + pages - 4) == activePage
                                ? CustomTextStyles.labelLargeWhite
                                : CustomTextStyles.labelLargeBlack,
                            onPressed: () {
                              onTap(index + pages - 4);
                            },
                          );
                        }),
                      )
                    : Row(
                        children: [
                          Wrap(
                            runSpacing: 8,
                            children: List.generate(5, (index) {
                              return CustomElevatedButton(
                                text: '${activePage + index}',
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                width: 31,
                                height: 30,
                                buttonStyle: (activePage + index) == activePage
                                    ? CustomButtonStyles.numberFillPrimary
                                    : CustomButtonStyles
                                        .numberFillPrimaryTransparent,
                                buttonTextStyle:
                                    (activePage + index) == activePage
                                        ? CustomTextStyles.labelLargeWhite
                                        : CustomTextStyles.labelLargeBlack,
                                onPressed: () {
                                  onTap(activePage + index);
                                },
                              );
                            }),
                          ),
                          (pages - activePage) == 5
                              ? const SizedBox.shrink()
                              : Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CustomImageView(
                                      imagePath: IconConstant.more,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                          CustomElevatedButton(
                            text: '$pages',
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 31,
                            height: 30,
                            buttonStyle:
                                CustomButtonStyles.numberFillPrimaryTransparent,
                            buttonTextStyle: CustomTextStyles.labelLargeBlack,
                            onPressed: () => onTap(pages),
                          ),
                        ],
                      ),
              ],
            ),
      const SizedBox(
        width: 8,
      ),
      GestureDetector(
          child: CustomImageView(
            imagePath: IconConstant.nextPage,
            width: 24,
            height: 24,
          ),
          onTap: () {
            if (activePage == pages) {
              return;
            } else {
              onTap(activePage + 1);
            }
          }),
      const SizedBox(
        width: 8,
      ),
      GestureDetector(
          child: CustomImageView(
            imagePath: IconConstant.lastPage,
            width: 24,
            height: 24,
          ),
          onTap: () {
            if (activePage == pages) {
              return;
            } else {
              onTap(pages);
            }
          }),
    ]);
  }
}
