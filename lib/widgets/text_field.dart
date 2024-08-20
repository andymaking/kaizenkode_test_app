import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '/utils/widget_extensions.dart';
import 'apptexts.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final String? hint;
  final String? labelText;
  final bool readonly;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? errorWidget;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? label;
  final Widget? prefix;
  final double? textSize;
  final double? borderRadius;
  final Color? hintColor;
  final Color? bodyTextColor;
  final Color? fillColor;
  final Color? textColor;
  final bool? enabled;
  final bool? overrideIconColor;
  final VoidCallback? onTap;
  final AutovalidateMode? autoValidateMode;
  final InputBorder? enabledBorder;
  final int? maxLength;
  final FontWeight? fontWeight;
  final int? maxHeight;
  final bool? haveText;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const AppTextField(
      {Key? key,
        this.readonly = false,
        this.isPassword = false,
        this.hintText,
        this.hint,
        this.onChanged,
        this.controller,
        this.keyboardType = TextInputType.text,
        this.onTap,
        this.onEditingComplete,
        this.onFieldSubmitted,
        this.validator,
        this.autofillHints,
        this.suffixIcon,
        this.textSize,
        this.haveText,
        this.maxLength,
        this.labelText,
        this.label,
        this.contentPadding,
        this.prefix, this.maxHeight = 1, this.hintColor, this.textColor, this.inputFormatters, this.errorWidget, this.enabled, this.fillColor, this.overrideIconColor, this.enabledBorder, this.autoValidateMode, this.borderRadius, this.bodyTextColor, this.textInputAction, this.fontWeight})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hintText != null
              ? Column(
            children: [
              AppText(
                widget.hintText ?? "",
                size: widget.textSize ?? 13.5.sp,
                color :widget.hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
                // isBold: true,
                align: TextAlign.start,
                weight: FontWeight.w500,
              ),
              5.0.sbH,
            ],
          )
              : 0.0.sbH,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  validator: widget.validator,
                  autofillHints: widget.autofillHints,
                  onEditingComplete: widget.onEditingComplete,
                  autovalidateMode: widget.autoValidateMode,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  maxLines: widget.maxHeight,
                  focusNode: _focusNode,
                  maxLength: widget.maxLength,
                  onChanged: (val) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(val);
                    }
                  },
                  onTap: widget.onTap,
                  readOnly: widget.readonly,
                  enabled: widget.enabled,
                  obscureText: widget.isPassword ? !isVisible : false,
                  textInputAction: widget.textInputAction?? TextInputAction.next,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, color: widget.bodyTextColor, fontWeight: widget.fontWeight?? FontWeight.bold),
                  controller: widget.controller,
                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    filled: true, // Add this line to enable filled decoration
                    errorMaxLines: 3,
                    counter: 0.0.sbH,
                    hintText: widget.hint,
                    enabled: widget.enabled??true,
                    fillColor: Colors.transparent,
                    error: widget.errorWidget,
                    prefixIconColor: widget.overrideIconColor ==true? null: const Color(0xFF2A2A2A),
                    suffixIconColor: widget.overrideIconColor ==true? null: const Color(0xFF2A2A2A),
                    prefixIcon: widget.prefix==null? null : SizedBox(height: 40.sp, width: 40.sp ,child: Align(alignment: Alignment.center, child: widget.prefix)),
                    suffixIcon: widget.suffixIcon ?? (widget.isPassword
                        ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: widget.suffixIcon ??
                            Icon(isVisible
                                ? Iconsax.eye_slash
                                : Iconsax.eye, size: 20,
                              color: Theme.of(context).unselectedWidgetColor,
                            ))
                        : widget.suffixIcon),

                    label: widget.label,
                    labelText: widget.labelText,
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: widget.textColor, fontSize: 15.sp),
                    helperStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp,),
                    isDense: true,
                    contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
                    border: InputBorder.none
                  ),
                  keyboardType: widget.keyboardType,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class TextArea extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final TextAlign? textAlign;
  final TextInputType? keyBoardType;
  final String? Function(String? val)? validationCallback;
  final void Function()? onEdittingComplete;
  final String? formError;
  final String label;
  final String? hintText;
  final FocusNode? focusnode;
  final TextEditingController? controller;
  final String? message;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Function()? clearForm;
  final Function()? onTap;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool? enabled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool? show;
  final Color? fillColor;
  final Color? hintColor;
  final bool? showCursor;
  final bool readOnly;
  final Widget? labelRightItem;
  final TextStyle? labelStyle;
  final int? minLines;
  final int? maxLines;

  const TextArea({super.key,
    this.autovalidateMode,
    this.inputFormatters,
    this.textAlign,
    this.keyBoardType,
    this.onEdittingComplete,
    this.validationCallback,
    this.message,
    this.hintText,
    this.label="",
    this.formError,
    this.focusnode,
    this.controller,
    this.clearForm,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.enabled = true,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.fillColor,
    this.hintColor,
    this.showCursor,
    this.readOnly = false,
    this.labelRightItem,
    this.labelStyle, this.show,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        label.isEmpty || label==""?0.0.sbH:AppText(
          label,
          size: 14,
          align: TextAlign.start,
        ),
        label.isEmpty || label==""?0.0.sbH:8.0.sbH,
        TextField(
          showCursor: showCursor,
          readOnly: readOnly,
          maxLength: 1000,
          enabled: enabled,
          onTap: onTap,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
          minLines: minLines,
          maxLines: 5,
          focusNode: focusnode,
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: show==null?Theme.of(context).dividerColor.withOpacity(0.07):Colors.transparent,
            counterText: '',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, color: hintColor),
            isDense: true,
            hintText: hintText,
            errorText: formError,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            filled: true,
          ),
          textAlign: textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters,
          keyboardType: keyBoardType,
          onChanged: onChanged,
          onEditingComplete: onEdittingComplete,
          obscureText: obscureText ?? false,
        ),
      ],
    );
  }
}

