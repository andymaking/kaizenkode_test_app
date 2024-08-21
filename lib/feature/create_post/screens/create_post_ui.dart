import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaizenkode_test_app/data/cache/app_image.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';
import 'package:kaizenkode_test_app/feature/create_post/provider/create_post_provider.dart';
import 'package:kaizenkode_test_app/feature/create_post/provider/create_post_provider.dart';
import 'package:kaizenkode_test_app/feature/home/provider/home.provider.dart';
import 'package:kaizenkode_test_app/utils/widget_extensions.dart';
import 'package:kaizenkode_test_app/widgets/apptexts.dart';
import 'package:kaizenkode_test_app/widgets/text_field.dart';

class CreatePostScreen extends ConsumerWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createPostStateProvider = ref.watch(createPostProvider);
    final dashStateProvider = ref.watch(dashBoardProvider);
    final createPostDataProvider = ref.read(createPostProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: AppText("Create Post", isNino: true, size: 16.sp, weight: FontWeight.w700,),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: ()=> createPostDataProvider.submit(context),
            child:  AppText(
                "Post",
                isNino: true,
                size: 16.sp,
                weight: FontWeight.w700,
                color: Colors.white
            )
          ),
          12.w.sbW
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: 16.w.padH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.h.sbH,
                    Row(
                      children: List.generate(
                          createPostStateProvider.types.length,
                              (index){
                            return Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.r),
                                onTap: ()=> createPostDataProvider.changePostType(createPostStateProvider.types[index]),
                                child: Container(
                                  height: 29.h,
                                  alignment: Alignment.center,
                                  margin: index%2 == 0? 8.w.padR: 8.w.padL,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: createPostStateProvider.selectedPostType == createPostStateProvider.types[index]? AppColors.primaryColor: null,
                                      border: Border.all(width: 1.w, color: createPostStateProvider.selectedPostType == createPostStateProvider.types[index]? AppColors.primaryColor: AppColors.secondaryTextColor)
                                  ),
                                  child: AppText(
                                    createPostStateProvider.types[index],
                                    isNino: true,
                                    weight: FontWeight.w700,
                                    color: createPostStateProvider.selectedPostType == createPostStateProvider.types[index]? Colors.white: null,
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    20.h.sbH,
                    Expanded(
                      child: ListView(
                        children: [
                          TextArea(
                            controller: createPostDataProvider.messageController,
                            onChanged: createPostDataProvider.onChanged,
                            autoFocus: true,
                            hintText: "Type Something...",
                            maxLines: 10,

                          ),
                        ],
                      )
                    ),
                    10.h.sbH,
                    const AppText(
                      "Topic",
                      isNino: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
              width: width(context),
              child: ListView.builder(
                padding: 16.w.padL,
                itemCount: dashStateProvider.allTopics.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index){
                  return InkWell(
                    borderRadius: BorderRadius.circular(15.r),
                    onTap: ()=> createPostDataProvider.changePostTopic(dashStateProvider.allTopics[index]),
                    child: Container(
                      height: 29.h,
                      alignment: Alignment.center,
                      padding: 10.w.padH,
                      margin: 16.w.padR,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: createPostStateProvider.selectedTopic == dashStateProvider.allTopics[index]? AppColors.primaryColor: null,
                          border: Border.all(width: 1.w, color: createPostStateProvider.selectedTopic == dashStateProvider.allTopics[index]? AppColors.primaryColor: AppColors.secondaryTextColor)
                      ),
                      child: AppText(
                        dashStateProvider.allTopics[index],
                        isNino: true,
                        size: 13.sp,
                        weight: FontWeight.w700,
                        color: createPostStateProvider.selectedTopic ==dashStateProvider.allTopics[index]? Colors.white: null,
                      ),
                    ),
                  );
                }
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.sp.sbH,
                if (createPostStateProvider.images.isNotEmpty) Padding(
                  padding: 16.w.padH,
                  child: IntrinsicWidth(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(
                            height: 114.h,
                            fit: BoxFit.fitHeight,
                            File(createPostStateProvider.images[0])
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: createPostDataProvider.removeImage,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                AppImages.close,
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ) else Padding(
                  padding: 16.w.padH,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=> createPostDataProvider.pickImage(imageSource: ImageSource.camera),
                        child: SvgPicture.asset(
                          AppImages.addCamera,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                      16.sp.sbW,
                      InkWell(
                        onTap: ()=> createPostDataProvider.pickImage(imageSource: ImageSource.gallery),
                        child: SvgPicture.asset(
                          AppImages.addGallery,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                      16.sp.sbW,

                    ],
                  ),
                ),
                16.sp.sbH,
              ],
            )
          ],
        ),
      ),
    );
  }
}
