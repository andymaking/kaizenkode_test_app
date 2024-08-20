import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kaizenkode_test_app/data/cache/app_image.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';

import '../../data/routes/app_routers.dart';
import '../../widgets/apptexts.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  final String name = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final ValueNotifier<int> _bottomBarIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(
      myInterceptor,
      name: widget.name,
      context: context,
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  void goBranch(int index) {
    final currentIndex = _bottomBarIndex.value;
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == currentIndex,
    );
    _bottomBarIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: widget.navigationShell,
      bottomNavigationBar: SizedBox(
        height: (24.h + 69.h),
        child: Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Row(
            children: [
              _NavigationBarItem(
                label: "Home",
                icon: AppImages.homeIcon,
                isSelected: _bottomBarIndex.value == 0,
                activeIcon: AppImages.homeIconActive,
                index: 0,
                onTap: goBranch
              ),
              _NavigationBarItem(
                label: "Search",
                icon: AppImages.searchIcon,
                activeIcon: AppImages.searchIcon,
                isSelected: _bottomBarIndex.value == 1,
                index: 1,
                onTap: goBranch
              ),
              _NavigationBarItem(
                label: "Create",
                icon: AppImages.createPostIcon,
                activeIcon: AppImages.createPostIcon,
                index: 7,
                onTap: (i){
                  context.push(AppRoute.createPost);
                }
              ),
              _NavigationBarItem(
                  label: "Chat",
                  icon: AppImages.chatIcon,
                  activeIcon: AppImages.chatIconActive,
                  isSelected: _bottomBarIndex.value == 2,
                  index: 2,
                  onTap: goBranch
              ),
              _NavigationBarItem(
                  label: "Profile",
                  icon: AppImages.profileIcon,
                  activeIcon: AppImages.profileIcon,
                  isSelected: _bottomBarIndex.value == 3,
                  index: 3,
                  onTap: goBranch
              ),
            ],
          ),
        ),
      )
    );
  }

  FutureOr<bool> myInterceptor(
      bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    if (widget.navigationShell.currentIndex != 0) {
      goBranch(0);
      return true;
    }
    return false;
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.index,
    this.isSelected = false,
    required this.onTap,
    this.count
  }) : super(key: key);

  final String label;
  final String icon;
  final String activeIcon;
  final int index;
  final int? count;
  final bool isSelected;
  ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 69.h,
        alignment: Alignment.center,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            onTap(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isSelected? activeIcon: icon,
                height: 24.sp, width: 24.sp,
                color:  isSelected? AppColors.primaryColor : null
              ),
              FittedBox(
                child: AppText(
                  label, size: 12.sp ,align: TextAlign.center, weight: isSelected? FontWeight.w700: FontWeight.w500, color:  isSelected? AppColors.primaryColor : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}