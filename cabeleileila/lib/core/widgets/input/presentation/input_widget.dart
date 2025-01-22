import 'package:cabeleileila/core/colors/colors_system.dart';
import 'package:cabeleileila/core/enums/input_enums.dart';
import 'package:cabeleileila/core/widgets/input/state/input_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final InputType inputType;
  final String? placeholder;
  final TextEditingController controller;
  final bool? verifySameWeek;
  final List<String>? itemsSelector;

  const InputWidget({
    super.key,
    required this.label,
    required this.inputType,
    this.placeholder,
    required this.controller,
    this.verifySameWeek,
    this.itemsSelector,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late InputWidgetController _controller;

  final numberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      "#": RegExp(r'[0-9]')
    },
  );

  @override
  void initState() {
    super.initState();
    _controller = InputWidgetController();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.inputType) {
      case InputType.select:
        return _inputSelect();
      case InputType.date:
        return _inputDate();
      case InputType.hour:
        return _inputHour();
      case InputType.number:
        return _inputNumber();
      case InputType.password:
        return _inputPassword();
      case InputType.string:
        return _inputString();
    }
  }

  Widget _inputSelect() {
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
        DropdownMenu<String>(
          controller: widget.controller,
          dropdownMenuEntries: widget.itemsSelector!.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              label: value,
              value: value,
            );
          }).toList(),
          onSelected: (String? newValue) {},
        ),
      ],
    );
  }

  Widget _inputDate() {
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
          height: 40,
          width: double.infinity,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: 14,
                color: SystemColors.secondary,
              ),
              border: const OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.calendar_month,
                color: SystemColors.secondary,
                size: 16,
              ),
              contentPadding: EdgeInsets.all(8),
            ),
            onTap: () => _controller.selectDate(context, widget.controller),
          ),
        )
      ],
    );
  }

  Widget _inputHour() {
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
          height: 40,
          width: double.infinity,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: 14,
                color: SystemColors.secondary,
              ),
              border: const OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.access_time,
                color: SystemColors.secondary,
                size: 16,
              ),
              contentPadding: EdgeInsets.all(8),
            ),
            onTap: () => _controller.selectTime(context, widget.controller),
          ),
        )
      ],
    );
  }

  Widget _inputNumber() {
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
          height: 40,
          width: double.infinity,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: 14,
                color: SystemColors.secondary,
              ),
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
            inputFormatters: widget.inputType == InputType.number
                ? [
                    numberFormatter
                  ]
                : null,
            keyboardType: widget.inputType == InputType.number ? TextInputType.numberWithOptions() : null,
          ),
        )
      ],
    );
  }

  Widget _inputPassword() {
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
          height: 40,
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      value == true ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: SystemColors.secondary,
                      size: 16,
                    ),
                    onPressed: () {
                      _controller.setObscurePassword(!value);
                    },
                  ),
                  contentPadding: EdgeInsets.all(8),
                ),
                obscureText: value,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _inputString() {
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
          height: 40,
          width: double.infinity,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: 14,
                color: SystemColors.secondary,
              ),
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        )
      ],
    );
  }
}
