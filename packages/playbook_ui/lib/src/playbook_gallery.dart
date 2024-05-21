import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_ui/src/component/component.dart';
import 'package:playbook_ui/src/scenario_container.dart';

class PlaybookGallery extends StatefulWidget {
  const PlaybookGallery({
    super.key,
    this.title = 'Playbook',
    this.canvasColor = Colors.white,
    this.checkeredColor = Colors.black12,
    this.scenarioThumbnailScale = 0.3,
    this.searchTextController,
    this.onCustomActionPressed,
    this.otherCustomActions = const [],
    required this.playbook,
    this.scenarioWidgetBuilder,
  });

  final String title;
  final Color? canvasColor;
  final Color? checkeredColor;
  final double scenarioThumbnailScale;
  final TextEditingController? searchTextController;
  final VoidCallback? onCustomActionPressed;
  final List<Widget> otherCustomActions;
  final Playbook playbook;
  final ScenarioWidgetBuilder? scenarioWidgetBuilder;

  @override
  PlaybookGalleryState createState() => PlaybookGalleryState();
}

class PlaybookGalleryState extends State<PlaybookGallery> {
  final TextEditingController _defaultSearchTextController =
      TextEditingController();
  TextEditingController get _effectiveSearchTextController =>
      widget.searchTextController ?? _defaultSearchTextController;

  final _scrollController = ScrollController();
  List<Story> _stories = [];

  @override
  void initState() {
    super.initState();
    _defaultSearchTextController.addListener(_searchTextListener);
    widget.searchTextController?.addListener(_searchTextListener);
    _updateStoriesFromSearch();
  }

  @override
  void dispose() {
    widget.searchTextController?.removeListener(_searchTextListener);
    _defaultSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: SearchBox(
          controller: _effectiveSearchTextController,
        ),
        actions: [
          if (widget.onCustomActionPressed != null)
            IconButton(
              onPressed: widget.onCustomActionPressed,
              icon: const Icon(Icons.settings),
            ),
          ...widget.otherCustomActions,
        ],
      ),
      drawer: StoryDrawer(
        stories: _stories,
        textController: _effectiveSearchTextController,
      ),
      onDrawerChanged: (opened) {
        if (opened) _unfocus();
      },
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.folder_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      story.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                key: PageStorageKey(index),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                child: Wrap(
                  spacing: 16,
                  children: story.scenarios
                      .map(
                        (e) => ScenarioContainer(
                          key: ValueKey(e),
                          scenario: e,
                          thumbnailScale: widget.scenarioThumbnailScale,
                          canvasColor: widget.canvasColor,
                          checkeredColor: widget.checkeredColor,
                          widgetBuilder: widget.scenarioWidgetBuilder,
                        ),
                      )
                      .toList()
                    ..sort(
                      (s1, s2) =>
                          s1.scenario.title.compareTo(s2.scenario.title),
                    ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PlaybookGallery oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchTextController != oldWidget.searchTextController) {
      oldWidget.searchTextController?.removeListener(_searchTextListener);
      widget.searchTextController?.addListener(_searchTextListener);

      if (widget.searchTextController == null) {
        // Inherit the value from oldWidget
        _defaultSearchTextController.value =
            oldWidget.searchTextController?.value ?? TextEditingValue.empty;
      }
    }
    _updateStoriesFromSearch();
  }

  void _searchTextListener() {
    setState(_updateStoriesFromSearch);
  }

  void _updateStoriesFromSearch() {
    if (_effectiveSearchTextController.text.isEmpty) {
      _stories = widget.playbook.stories.toList();
    } else {
      final reg = RegExp(
        _effectiveSearchTextController.text,
        caseSensitive: false,
      );
      _stories = widget.playbook.stories
          .map(
            (story) => Story(
              story.title,
              scenarios: story.title.contains(reg)
                  ? story.scenarios
                  : story.scenarios
                      .where((scenario) => scenario.title.contains(reg))
                      .toList(),
            ),
          )
          .where((story) => story.scenarios.isNotEmpty)
          .toList();
    }
    _stories.sort((s1, s2) => s1.title.compareTo(s2.title));
  }

  void _unfocus() {
    // see: https://github.com/flutter/flutter/issues/54277#issuecomment-640998757
    final currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
