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
    final theme = Theme.of(context);
    return Material(
      shape: const StadiumBorder(),
      color: theme.colorScheme.onSurface.withOpacity(0.06),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: theme.copyWith(
          // Change prefixIcon/suffixIcon active color
          colorScheme: theme.colorScheme.copyWith(
            primary: theme.disabledColor,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          cursorColor: theme.primaryColor,
          style: theme.textTheme.headline6,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: const Icon(Icons.search, size: 32),
            suffixIcon: _hasText
                ? IconButton(
                    onPressed: () => widget.controller.clear(),
                    icon: const Icon(Icons.cancel, size: 24),
                  )
                : null,
            hintText: 'Search',
          ),
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
