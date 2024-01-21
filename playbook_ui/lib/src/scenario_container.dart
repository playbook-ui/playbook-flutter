import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';
import 'package:playbook_ui/src/component/component.dart';

class ScenarioContainer extends StatelessWidget {
  const ScenarioContainer({
    super.key,
    required this.scenario,
    required this.thumbnailScale,
  });

  final Scenario scenario;
  final double thumbnailScale;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thumbnailSize = size * thumbnailScale;
    return ScalableButton(
      child: Column(
        children: [
          Card(
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: SizedBox(
              width: thumbnailSize.width,
              height: thumbnailSize.height,
              child: Stack(
                children: [
                  Positioned(
                    width: size.width,
                    height: size.height,
                    child: Focus(
                      descendantsAreFocusable: false,
                      child: IgnorePointer(
                        child: Transform.scale(
                          alignment: Alignment.topLeft,
                          scale: thumbnailScale,
                          child: Align(
                            alignment: scenario.alignment,
                            child: HeroMode(
                              // Because we may have multiple heroes
                              // that share the same tag
                              enabled: false,
                              child: scenario.child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: thumbnailSize.width,
            alignment: Alignment.center,
            child: Text(
              scenario.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          MaterialPageRoute<dynamic>(
            fullscreenDialog: true,
            builder: (context) {
              return DialogScaffold(
                title: Text(scenario.title),
                body: ScenarioWidget(scenario: scenario),
              );
            },
          ),
        );
      },
    );
  }
}
