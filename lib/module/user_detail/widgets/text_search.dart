import 'package:dummyapi_client/const/color.dart';
import 'package:dummyapi_client/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class TextSearch extends StatefulWidget {
  final TextEditingController controller;
  final String title;

  const TextSearch({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  @override
  _TextSearchState createState() => _TextSearchState();
}

class _TextSearchState extends State<TextSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kLightGrey, width: 1.5),
        borderRadius: BorderRadius.circular(15.0),
        color: kLightGrey,
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: HeroIcon(
              HeroIcons.search,
              solid: false,
              size: 20,
              color: kPrimaryColor,
            ),
          ),
          Expanded(
            flex: 7,
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: widget.controller,
              onChanged: (text) {
                setState(() {});
              },
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.title,
                hintStyle: reguler14,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.controller.text = "";
                    });
                  },
                  icon: (widget.controller.text != '')
                      ? const HeroIcon(
                          HeroIcons.x,
                          solid: false,
                          size: 20,
                          color: kGrey, // Outlined icons are used by default.
                        )
                      : const Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return TextFormField(
      keyboardType: TextInputType.text,
      controller: widget.controller,
      onChanged: (text) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: widget.title,
        labelText: widget.title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.controller.text = "";
            });
          },
          icon: (widget.controller.text != '')
              ? const HeroIcon(
                  HeroIcons.xCircle,
                  solid: false,
                  color: kDarkColor, // Outlined icons are used by default.
                )
              : const Center(),
        ),
      ),
    );
  }
}
