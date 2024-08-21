import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kaizenkode_test_app/data/cache/app_image.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';
import 'package:kaizenkode_test_app/utils/widget_extensions.dart';
import 'package:kaizenkode_test_app/widgets/apptexts.dart';

class TopicSelector extends StatelessWidget {
  final Function(String) onSelect;
  final List<String> topics;
  final String? selectedTopics;
  const TopicSelector({super.key, required this.onSelect, required this.topics, this.selectedTopics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 16.w.padH,
      itemCount: topics.length,
      itemBuilder: (_, i){
        return InkWell(
          onTap: (){
            onSelect(topics[i]);
            context.pop();
          },
          child: Container(
            height: 50.h,
            margin: 5.sp.padB,
            padding: 16.sp.padH,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: selectedTopics == topics[i]? AppColors.primaryColor: null
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.topic,
                  color: selectedTopics == topics[i]? Colors.white: null,
                ),
                10.sp.sbW,
                AppText(
                  topics[i],
                  color: selectedTopics == topics[i]? Colors.white: null,
                  weight: FontWeight.w600,),
              ],
            ),
          ),
        );
      }
    );
  }
}
