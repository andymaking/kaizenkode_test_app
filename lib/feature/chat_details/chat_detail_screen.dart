import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kaizenkode_test_app/data/cache/app_image.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';
import 'package:kaizenkode_test_app/feature/chat_home/provider/chat.provider.dart';
import 'package:kaizenkode_test_app/utils/widget_extensions.dart';
import 'package:kaizenkode_test_app/widgets/profile_picture_widget.dart';

import '../../../utils/format_chat_date.dart';
import '../../../widgets/apptexts.dart';
import '../../widgets/text_field.dart';
import '../chat_home/model/chat_model.dart';
import 'provider/chat_detail.provider.dart';

class ChatDetailScreen extends ConsumerWidget {
  final String? chatId;
  const ChatDetailScreen({super.key, this.chatId});

  static String toTime(DateTime dateTime){
    final time =DateFormat.Hm().format(dateTime);

    return time;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dashBoardStateProvider = ref.watch(chatHomeProvider);
    final chatProvider = ref.watch(chatDetailHomeProvider);
    final chatDetailNotifier = ref.read(chatDetailHomeProvider.notifier);

    ChatModel user = dashBoardStateProvider.allChats.firstWhere((e)=> e.id == chatId);

    List<Chats> chatResponse = user.chats??[];

    print(chatResponse.length);

    // Sort the chatResponse list by timestamp
    chatResponse.sort((a, b) {
      DateTime dateA = DateTime.parse(a.createdAt??"");
      DateTime dateB = DateTime.parse(b.createdAt??"");
      return dateA.compareTo(dateB);
    });

    // Group the messages by date
    Map<String, List<Chats>> groupedMessages = {};
    for (var chat in chatResponse) {
      String dateKey = formatDateString(chat.createdAt??"");
      if (groupedMessages[dateKey] == null) {
        groupedMessages[dateKey] = [];
      }
      groupedMessages[dateKey]?.add(chat);
    }

    List<Widget> messageWidgets = [];
    groupedMessages.forEach((date, messages) {
      messageWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.sp),
                  color: Colors.black54
              ),
              child: AppText(
                date,
                size: 10.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < messages.length; i++) {
        Chats chat = messages[i];
        bool isLastFromUser = i == messages.length - 1 || messages[i + 1].userID != chat.userID;
        messageWidgets.add(buildChatMessage(context, chat, "abcd", isLastFromUser, user));
      }
    });

    ScrollController _controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name??""),
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            AppImages.setting,
            height: 24.h,
            width: 24.w,
          ),
          10.w.sbW
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: 16.sp.padH,
              itemCount: messageWidgets.length,
              controller:_controller,
              itemBuilder: (_, i) {
                return messageWidgets[i];
              },
            ),
          ),
          Padding(
            padding: 16.sp.padA,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        AppImages.images,
                        height: 26.sp,
                        width: 26.sp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: AppTextField(
                      controller: chatDetailNotifier.textEditingController,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      hint: "Type something",
                      contentPadding: 14.sp.padA,
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(100.sp),
                        onTap: (){},
                        child: Container(
                          height: 24.h,
                          width: 24.w,
                          padding: 5.sp.padA,
                          child: SvgPicture.asset(
                            AppImages.sendMessage,
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildChatMessage(BuildContext context, Chats chat, String userID, bool isLastFromUser, ChatModel user) {
    return Padding(
      padding: 15.sp.padB,
      child: Row(
        mainAxisAlignment: userID != chat.userID? MainAxisAlignment.start: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isLastFromUser && userID != chat.userID) ...[
            Row(
              children: [
                ProfileImage(
                    image: user.profilePicture??"", size: 40
                ),
                10.sp.sbW,
              ],
            )
          ] else if(userID != chat.userID)  50.sp.sbW,
          Container(
            width: width(context) *0.7,
            padding: 13.sp.padA,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: AppColors.secondaryColor,
            ),
            child: Column(
              crossAxisAlignment: userID != chat.userID? CrossAxisAlignment.start: CrossAxisAlignment.end,
              children: [
                (chat.chat ?? "").toString().startsWith("http")?
                CachedNetworkImage(
                  imageUrl: chat.chat ?? "",
                  fit: BoxFit.fitWidth,
                ):
                AppText(
                  chat.chat ?? "",
                  style: GoogleFonts.nunito(
                    fontSize: 16.sp
                  ),
                ),
                5.sp.sbH,
                Row(
                  mainAxisAlignment:  userID != chat.userID? MainAxisAlignment.end: MainAxisAlignment.start,
                  children: [
                    AppText(toTime(DateTime.parse("${chat.createdAt}")), style: GoogleFonts.nunito(
                        fontSize: 12.sp
                    ),),
                  ],
                )
              ],
            )
          ),
          if (isLastFromUser && userID == chat.userID) ...[
            Row(
              children: [
                10.sp.sbW,
                ProfileImage(
                    image: "https://i.pravatar.cc/150?img=1", size: 40
                ),
              ],
            )
          ] else if(userID == chat.userID)  50.sp.sbW
        ],
      ),
    );
  }
}

