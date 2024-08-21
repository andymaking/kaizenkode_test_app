import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';
import 'package:kaizenkode_test_app/utils/widget_extensions.dart';

import '../../../data/cache/app_image.dart';
import '../../../widgets/apptexts.dart';
import '../model/post_model.dart';
import '../provider/home.provider.dart';
import '../widgets/feed_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dashBoardStateProvider = ref.watch(dashBoardProvider);
    final dashProvider = ref.watch(dashBoardProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText("Logo ", weight: FontWeight.w700, size: 18.sp,),
                SvgPicture.asset(AppImages.verificationBadge, height: 20.h, width: 20.w,)
              ],
            ),
            IconButton(
              onPressed: (){},
              icon: SvgPicture.asset(
                AppImages.bell,
                height: 20.h,
                width: 20.w,
              )
            )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: 16.h,),
            TabBar(
              automaticIndicatorColorAdjustment : false,
              indicatorColor: AppColors.primaryColor,
              indicatorSize : TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor
              ),
              tabs: [
                Tab(
                  text: "Public Feed",
                  height: 32.h,
                ),
                Tab(
                  text: "Business Feed",
                  height: 32.h,
                ),
              ]
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FeedScreen(
                    posts: dashBoardStateProvider.displayPublicPosts,
                    topic: dashBoardStateProvider.publicTopics,
                    filter: ()=> dashProvider.showFilterSheet(context, true),
                  ),
                  FeedScreen(
                    posts: dashBoardStateProvider.displayBusinessPosts,
                    topic: dashBoardStateProvider.businessTopics,
                    filter: ()=> dashProvider.showFilterSheet(context, false),
                  ),
                ],
              )
            )
          ],
        )
      ),
    );
  }
}

