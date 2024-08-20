import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLength;
  final double? fontSize;
  final FontWeight? weight;
  final TextAlign? align;
  final Color? color;

  SeeMoreText({required this.text, this.maxLength = 19,  this.fontSize, this.weight, this.align, this.color});

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    final String displayedText = _showFullText || widget.maxLength >= widget.text.length ? widget.text : widget.text.substring(0, widget.maxLength);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayedText,
          style: GoogleFonts.manrope(
            fontSize: widget.fontSize?? 10.sp,
            fontWeight: widget.weight,
            color: widget.color,
          ),
          textAlign: widget.align,
          // TextStyle(fontFamily: 'Spartan', height: 1.5, fontSize: 13),
        ),
        if (widget.text.length > widget.maxLength)
          GestureDetector(
            onTap: () {
              setState(() {
                _showFullText = !_showFullText;
              });
            },
            child: Text(
              _showFullText ? 'See Less' : 'See More',
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
      ],
    );
  }
}