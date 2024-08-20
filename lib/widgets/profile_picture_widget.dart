import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImage extends StatelessWidget {
  final String image;
  final double? size;
  const ProfileImage({super.key, required this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size != null? ((size??0)/2).r: 18.r),
      child: Container(
        height: (size??36).h,
        width: (size??36).w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    image
                ),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}