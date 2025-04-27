import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_controller.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_detail/free_board_detail_controller.dart';
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';

class FreeBoardDetailView extends GetWidget<FreeBoardDetailController> {
  const FreeBoardDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        body: PageLoadingIndicator(
          isLoading: controller.isLoading.value,
          child: controller.isInited.value
              ? ResponsiveWidget(
                  largeScreen: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenu(),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TobBarSearch(
                                    name: "Free Board detail".tr,
                                    searchShow: false,
                                    viewCount: false,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildSubMenu(),
                                  const SizedBox(height: 32),
                                  _buildInfo(),
                                  const SizedBox(height: 32),
                                  _buildComment(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          child: Text(
            "Free Board list".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => Get.offAllNamed(AppRoutes.freeBoardManage),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Free Board detail".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Title".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.freeBoardDetailModel.title!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              Visibility(
                visible: Account.isMaster(
                    controller.freeBoardDetailModel.masterEmail!),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () => controller.onTapDelete(),
                        child: Text(
                          "Delete".tr,
                          style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: appTheme.skyBlue),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () => Get.offAllNamed(AppRoutes.freeBoardEdit,
                            arguments: {RouteArguments.id: controller.id}),
                        child: Text(
                          "Edit".tr,
                          style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: appTheme.skyBlue),
                        )),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Body".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.freeBoardDetailModel.content!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text('Attached File'.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 16),
          controller.freeBoardDetailModel.attachedFile != null
              ? ImageActionsWidget(
                  imageUrl: controller.freeBoardDetailModel.attachedFile!,
                )
              : const SizedBox.shrink(),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Author".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.freeBoardDetailModel.masterNickname!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Views".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.freeBoardDetailModel.views.toString(),
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Date".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      DateFormat('yyyy-MM-dd HH:mm')
                          .format(controller.freeBoardDetailModel.createdAt!),
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComment() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Comment List".tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(
            height: 16,
          ),
          _buildCommentList(),
          const SizedBox(
            height: 8,
          ),
          _buildCommentInput()
        ],
      ),
    );
  }

  Widget _buildCommentList() {
    final comments = controller.freeBoardCommentListModel.comments;

    if (comments == null || comments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          "No comments yet.".tr,
          style: CustomTextStyles.bodyMediumGray,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Comment Author and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(comment.masterNickname ?? "Unknown",
                        style: CustomTextStyles.bodyMediumBlack),
                    Text(
                        DateFormat(' ᛫ yyyy-MM-dd HH:mm')
                            .format(comment.createdAt!),
                        style: CustomTextStyles.bodyMediumGray),
                  ],
                ),
                Visibility(
                  visible: Account.isMaster(comment.masterEmail!),
                  child: InkWell(
                      onTap: () => controller.onTapDeleteComment(comment.id!),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Delete".tr,
                          style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: appTheme.skyBlue),
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              comment.content ?? "",
              style: CustomTextStyles.bodyMediumBlack,
            ),
            Divider(
              height: 49,
              thickness: 1,
              color: appTheme.grayScale2,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCommentInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Write a Comment".tr, style: CustomTextStyles.labelMediumGray),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            KeyboardListener(
              focusNode: controller.focusNode,
              onKeyEvent: (KeyEvent evt) {
                if (evt.logicalKey.keyLabel == 'Enter') {
                  if (evt is KeyDownEvent) {
                    controller.nextLine();
                  }
                }
              },
              child: CustomTextFormField(
                textInputAction: TextInputAction.newline,
                width: 730,
                textInputType: TextInputType.multiline,
                maxLines: 3,
                controller: controller.commentController,
                hintText: "Input text".tr,
                contentPadding: const EdgeInsets.all(16),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "This field is required.".tr;
                //   }
                //   return null;
                // },
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            CustomElevatedButton(
              text: 'Save'.tr,
              buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
              buttonStyle: CustomButtonStyles.fillPrimary,
              // width: 90,
              height: 44,
              onPressed: () {
                controller.onSave();
              },
            ),
          ],
        ),
      ],
    );
  }
}
