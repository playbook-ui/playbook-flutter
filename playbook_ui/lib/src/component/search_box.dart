import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late bool _hasText = widget.controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.48);
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          size: 32,
          color: iconColor,
        ),
        suffixIcon: _hasText
            ? IconButton(
                onPressed: () => widget.controller.clear(),
                icon: Icon(
                  Icons.cancel,
                  size: 24,
                  color: iconColor,
                ),
              )
            : null,
        hintText: 'Search',
      ),
    );
  }

  void _onTextChanged() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
    });
  }
}
