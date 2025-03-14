import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import 'package:playbook_ui/src/component/component.dart';

class StoryDrawer extends StatefulWidget {
  const StoryDrawer({
    super.key,
    required this.stories,
    required this.textController,
  });

  final List<Story> stories;
  final TextEditingController textController;

  @override
  StoryDrawerState createState() => StoryDrawerState();
}

class StoryDrawerState extends State<StoryDrawer> {
  final expandedIndex = <int>{};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Material(
                shape: const StadiumBorder(),
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.06),
                clipBehavior: Clip.antiAlias,
                child: SearchBox(
                  controller: widget.textController,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final story = widget.stories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton.icon(
                      onPressed: () {
                        widget.textController.text = story.title;
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.folder_outlined),
                      label: SizedBox(
                        width: double.infinity,
                        child: Text(
                          story.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.stories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
