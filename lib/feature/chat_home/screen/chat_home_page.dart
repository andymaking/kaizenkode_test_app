import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kaizenkode_test_app/widgets/profile_picture_widget.dart';

import '../../../data/cache/app_image.dart';
import '../../../data/cache/palette.dart';
import '../../../utils/widget_extensions.dart';
import '../../../widgets/apptexts.dart';
import '../model/chat_model.dart';
import '../provider/chat.provider.dart';

class ChatHomeScreen extends ConsumerWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dashBoardStateProvider = ref.watch(chatHomeProvider);
    final dashBoardReader = ref.read(chatHomeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText("Messages ", weight: FontWeight.w700, size: 18.sp,),
              ],
            ),
            SvgPicture.asset(
              AppImages.addImage,
              height: 30.h,
              width: 30.w,
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: dashBoardStateProvider.allChats.length,
        padding: 16.w.padH,
        itemBuilder: (_, i){
          ChatModel chats = dashBoardStateProvider.allChats[i];
          return InkWell(
            onTap: ()=> dashBoardReader.goToChat(chats.id??"", context),
            child: Container(
              width: width(context) - 32.w,
              margin: 8.h.padV,
              padding: 16.sp.padA,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(14.r)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileImage(
                    image: chats.profilePicture??"",
                    size: 40,
                  ),
                  10.w.sbW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppText(chats.name??"", size: 16.sp, weight: FontWeight.w700,),
                        Row(
                          children: [
                            Expanded(child: AppText(chats.lastMessage??"", maxLine: 1, color: AppColors.secondaryTextColor)),
                          ],
                        ),
                        10.h.sbH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(Jiffy.parse(chats.createdAt??"").fromNow(), size: 12.sp, color: AppColors.secondaryTextColor,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppText("${chats.chats?.length??0}  ",style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w500
                                ),),
                                SvgPicture.asset(
                                  AppImages.comments,
                                  height: 20.h, width: 20.w,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}