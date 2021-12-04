import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import 'component.dart';

class StoryDrawer extends StatefulWidget {
  const StoryDrawer({
    Key? key,
    required this.stories,
    required this.textController,
    required this.onStoryPressed,
  }) : super(key: key);

  final List<Story> stories;
  final TextEditingController textController;
  final ValueChanged<int> onStoryPressed;

  @override
  _StoryDrawerState createState() => _StoryDrawerState();
}

class _StoryDrawerState extends State<StoryDrawer> {
  final expandedIndex = <int>{};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SearchBar(
                controller: widget.textController,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final story = widget.stories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onStoryPressed(index);
                      },
                      icon: const Icon(Icons.folder_outlined, color: Colors.blue),
                      label: SizedBox(
                        width: double.infinity,
                        child: Text(
                          story.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.bold),
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
