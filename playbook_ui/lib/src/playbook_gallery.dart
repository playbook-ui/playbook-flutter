import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import 'component/component.dart';
import 'scenario_container.dart';

class PlaybookGallery extends StatefulWidget {
  const PlaybookGallery({
    Key? key,
    this.title = '',
    this.onCustomActionPressed,
    this.otherCustomActions = const [],
    required this.playbook,
  }) : super(key: key);

  final String title;
  final VoidCallback? onCustomActionPressed;
  final List<Widget> otherCustomActions;
  final Playbook playbook;

  @override
  _PlaybookGalleryState createState() => _PlaybookGalleryState();
}

class _PlaybookGalleryState extends State<PlaybookGallery> {
  final _textEditingController = TextEditingController();
  List<Story> _stories = [];

  @override
  void initState() {
    super.initState();
    _updateStoriesFromSearch();
    _textEditingController.addListener(() {
      setState(_updateStoriesFromSearch);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
        drawer: StoryDrawer(
          stories: _stories,
          textController: _textEditingController,
          onStoryPressed: (title) async {},
        ),
        onDrawerChanged: (opened) {
          if (opened) _unfocus();
        },
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 128,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.title),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBar(
                  controller: _textEditingController,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final story = _stories.elementAt(index);
                  return Column(
                    key: ValueKey(story.title),
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
                                  .headline6
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
                              .map((e) => ScenarioContainer(key: ValueKey(e), scenario: e))
                              .toList()
                            ..sort(
                              (s1, s2) => s1.scenario.title.compareTo(s2.scenario.title),
                            ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
                childCount: _stories.length,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PlaybookGallery oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateStoriesFromSearch();
  }

  void _updateStoriesFromSearch() {
    if (_textEditingController.text.isEmpty) {
      _stories = widget.playbook.stories.toList();
    } else {
      final reg = RegExp(_textEditingController.text, caseSensitive: false);
      _stories = widget.playbook.stories
          .map(
            (story) => Story(
              story.title,
              scenarios: story.title.contains(reg)
                  ? story.scenarios
                  : story.scenarios.where((scenario) => scenario.title.contains(reg)).toList(),
            ),
          )
          .where((story) => story.scenarios.isNotEmpty)
          .toList();
    }
    _stories.sort((s1, s2) => s1.title.compareTo(s2.title));
  }

  void _unfocus() {
    // see: https://github.com/flutter/flutter/issues/54277#issuecomment-640998757
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
