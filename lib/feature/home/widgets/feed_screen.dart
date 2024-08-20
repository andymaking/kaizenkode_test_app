import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';

import '../../../data/cache/app_image.dart';
import '../../../data/cache/palette.dart';
import '../../../utils/widget_extensions.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/profile_picture_widget.dart';
import '../../../widgets/see_more.dart';
import '../model/post_model.dart';

class FeedScreen extends StatelessWidget {
  final List<PostModel> posts;
  final List<String> topic;
  const FeedScreen({super.key, required this.posts, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: ListView(
        padding: EdgeInsets.only(top: 16.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Feeds",
                isBold: true,
                size: 20.sp,
              ),
              SvgPicture.asset(
                AppImages.filter,
                height: 30.h,
                width: 30.w,
              )
            ],
          ),
          ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i){
                return Container(
                  width: width(context),
                  margin: 8.h.padV,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(14.r)
                  ),
                  child: Column(
                    children: [
                      16.h.sbH,
                      Padding(
                        padding: 16.w.padH,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ProfileImage(image: posts[i].profilePicture??"",),
                                    10.w.sbW,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            AppText(posts[i].name??"", weight: FontWeight.w600, size: 13.sp),
                                            10.w.sbW,
                                            SvgPicture.asset(AppImages.verificationBadge, height: 12.h, width: 12.w,),
                                            3.w.sbW,
                                            AppText(".", weight: FontWeight.w600, size: 13.sp),
                                            3.w.sbW,
                                            AppText(Jiffy.parse(posts[i].createdAt??"").fromNow(), size: 10.sp,)
                                          ],
                                        ),
                                        AppText(posts[i].topic??"", size: 10.sp)
                                      ],
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  AppImages.more,
                                  height: 30.h,
                                  width: 30.w,
                                )
                              ],
                            ),
                            15.h.sbH,
                            AppText(
                              posts[i].body??"",
                              weight: FontWeight.w500,
                              size: 10.sp,
                              color: AppColors.secondaryTextColor,
                            ),
                            10.h.sbH,
                          ],
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: posts[i].postImage??""
                      ),
                      Padding(
                        padding: 16.w.padA,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppImages.fav, height: 20.h, width: 20.w,),
                            16.w.sbW,
                            SvgPicture.asset(AppImages.message, height: 20.h, width: 20.w,),
                            16.w.sbW,
                            SvgPicture.asset(AppImages.send, height: 20.h, width: 20.w,),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
          50.h.sbH
        ],
      ),
    );
  }
}
