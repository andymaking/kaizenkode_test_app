import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaizenkode_test_app/utils/widget_extensions.dart';
import 'package:one_context/one_context.dart';
import '../widgets/drawer_appbar.dart';

Future<dynamic> appBottomSheet({required double ratio, required Widget child, required BuildContext context}) async {
  return showBottomSheet(
    backgroundColor: Colors.black12.withOpacity(0.1),
      enableDrag: true,
      context:  context,
      builder: (_){
        double heights = ratio;
        return DraggableScrollableSheet(
            initialChildSize: heights,
            snap: true,
            maxChildSize: 0.95,
            snapSizes: [heights, (heights+0.95)/2 ,0.95],
            builder:(_, scroll){
              return Container(
                decoration: BoxDecoration(
                    color: Theme.of(_).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      controller: scroll,
                      child: Padding(
                        padding: 16.sp.padA,
                        child: const BottomSheetAppBar(),
                      ),
                    ),
                    Expanded(
                      child: child,
                    )
                  ],
                ),
              );
            }
        );
      }
  );
}
