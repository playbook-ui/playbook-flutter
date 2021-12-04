import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _hasText = false;

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
    return Material(
      shape: const StadiumBorder(),
      color: Theme.of(context).cardColor,
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: const Icon(Icons.search, size: 32),
          suffixIcon: _hasText
              ? IconButton(
                  onPressed: () => widget.controller.clear(),
                  icon: const Icon(Icons.clear, size: 24),
                )
              : null,
          hintText: 'Search',
        ),
      ),
    );
  }

  void _onTextChanged() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
    });
  }
}
