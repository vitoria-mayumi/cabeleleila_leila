import 'package:cabeleileila/constants/colors/colors_constants.dart';
import 'package:cabeleileila/constants/enums/input_enums.dart';
import 'package:cabeleileila/view/widgets/inputWidget/state/input_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final InputType inputType;
  final String? placeholder;
  final TextEditingController controller;

  const InputWidget({
    super.key,
    required this.label,
    required this.inputType,
    this.placeholder,
    required this.controller,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late InputWidgetController _controller;

  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _controller = InputWidgetController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: SystemColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: widget.inputType == InputType.comment ? 220 : 40,
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: _controller.isObscurePassword,
            builder: (context, value, child) {
              return TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: SystemColors.secondary,
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: widget.inputType == InputType.password
                      ? IconButton(
                          icon: Icon(
                            value == true
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: SystemColors.secondary,
                            size: 16,
                          ),
                          onPressed: () {
                            _controller.setObscurePassword(!value);
                          },
                        )
                      : widget.inputType == InputType.calendar
                          ? Icon(
                              Icons.calendar_month,
                              color: SystemColors.secondary,
                              size: 16,
                            )
                          : null,
                  contentPadding: EdgeInsets.all(8),
                ),
                obscureText: value,
                inputFormatters: widget.inputType == InputType.number
                    ? [maskFormatter]
                    : null,
                keyboardType: widget.inputType == InputType.number
                    ? TextInputType.numberWithOptions()
                    : null,
              );
            },
          ),
        )
      ],
    );
  }
}
