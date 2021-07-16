import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final Widget? prefixIcon;
  final String? hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? semanticLabel;
  final Function(String)? onChanged;
  final Function(String)? onSubmited;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  bool? active;
  FocusNode? focusNode;
  String? initialData;
  bool? needTheSpace = true;
  final int? maxLines;
  String? Function(String?)? validator;

  CustomTextFormField(
      {this.prefixIcon,
        this.active,
      this.validator,
      this.hint,
      this.controller,
      this.suffixIcon,
      this.obscureText,
      this.inputFormatters,
      this.semanticLabel,
      this.onChanged,
      this.onSubmited,
      this.enabled,
      this.needTheSpace,
      this.maxLines,
      this.textAlign,
      this.keyboardType,
      this.initialData,
      this.focusNode});
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  ConstStyle constStyle = ConstStyle();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.needTheSpace! ? 10 : 0,
        ),
        TextFormField(
          enableInteractiveSelection: widget.active == null?true:widget.active!,
          validator: widget.validator,
          maxLines: widget.maxLines,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign!,
          enabled: widget.enabled,
          onFieldSubmitted: widget.onSubmited,
          onChanged: widget.onChanged,
          cursorColor: constStyle.tertiaryColor,
          obscureText: widget.obscureText!,
          controller: widget.controller,
          initialValue: widget.initialData,
          inputFormatters: widget.inputFormatters,

          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: constStyle.tertiaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: constStyle.tertiaryColor)),
              semanticCounterText: widget.semanticLabel,
              isDense: true,
              labelText: widget.hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: constStyle.tertiaryColor)),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon),
        )
      ],
    );
  }
}
