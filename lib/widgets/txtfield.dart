import 'package:flutter/material.dart';
import 'package:visionhr/widgets/reusetext.dart';
import '../utils/colors.dart';



class TxtField extends StatefulWidget {
  final String hintText;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool showSuffixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? labelText; // New
  final bool showLabelText; // New

  const TxtField({
    Key? key,
    required this.hintText,
    this.borderColor = AppColors.txtcolr,
    this.borderRadius = 25.0,
    this.padding = const EdgeInsets.only(left: 20),
    this.showSuffixIcon = false,
    required this.controller,
    this.validator,
    this.labelText, // New
    this.showLabelText = false, // New
  }) : super(key: key);

  @override
  _TxtFieldState createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabelText && widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ReuseText(
              data: widget.labelText!,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.txtcolr,
            ),
          ),
        SizedBox(height: 10,),
        Container(
          decoration: BoxDecoration(
            color: AppColors.nbgcolr,
            border: Border.all(color: AppColors.nbgcolr),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Padding(
            padding: widget.padding,
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText && widget.showSuffixIcon,
              style: TextStyle(color: AppColors.txtcolr),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'NunitoSans',
                  color: AppColors.txtcolr,
                ),
                suffixIcon: widget.showSuffixIcon
                    ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.txtcolr,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                    : null,
              ),
              validator: widget.validator,
            ),
          ),
        ),
      ],
    );
  }
}

