import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import 'component/component.dart';
import 'scenario_container.dart';

class PlaybookGallery extends StatefulWidget {
  PlaybookGallery({
    Key? key,
    String title = '',
    ThemeData? theme,
    required Playbook playbook,
  }) : this.builder(
          key: key,
          title: title,
          theme: theme,
          playbookBuilder: () => playbook,
        );

  PlaybookGallery.builder({
    Key? key,
    this.title = '',
    this.theme,
    required this.playbookBuilder,
  }) : super(key: key);

  final String title;
  final ThemeData? theme;
  final Playbook Function() playbookBuilder;

  @override
  _PlaybookGalleryState createState() => _PlaybookGalleryState();
}

class _PlaybookGalleryState extends State<PlaybookGallery> {
  final _textEditingController = TextEditingController();
  late Playbook _playbook;
  List<Story> _stories = [];

  @override
  void initState() {
    super.initState();
    _playbook = widget.playbookBuilder();
    _stories = _playbook.stories;

    _textEditingController.addListener(() {
      setState(_filterStories);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      theme: widget.theme ?? Theme.of(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 88,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: SearchHeaderDelegate(
                controller: _textEditingController,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final story = _stories.elementAt(index);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Icon(Icons.folder_outlined, color: Colors.blue),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              story.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.color,
                                  ),
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
                              .map((e) => ScenarioContainer(scenario: e))
                              .toList(),
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
  void reassemble() {
    super.reassemble();
    setState(() {
      _playbook = widget.playbookBuilder();
      _filterStories();
    });
  }

  void _filterStories() {
    if (_textEditingController.text.isEmpty) {
      _stories = _playbook.stories;
    } else {
      final reg = RegExp(_textEditingController.text, caseSensitive: false);
      _stories = _playbook.stories
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
  }
}
