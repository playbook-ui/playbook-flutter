import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import 'component/component.dart';

class ScenarioContainer extends StatelessWidget {
  const ScenarioContainer({
    Key? key,
    required this.scenario,
  }) : super(key: key);

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thumbnailSize = size * scenario.scale;
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
                          scale: scenario.scale,
                          child: Align(
                            alignment: scenario.alignment,
                            child: Theme(
                              data: ContentThemeProvider.of(context).theme,
                              // Because we may have multiple heroes that share the same tag
                              child: HeroMode(
                                enabled: false,
                                child: scenario.child,
                              ),
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
          const SizedBox(height: 8),
          Container(
            width: thumbnailSize.width,
            alignment: Alignment.center,
            child: Text(
              scenario.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        final contentTheme = ContentThemeProvider.of(context).theme;
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) {
            return DialogScaffold(
              title: Text(scenario.title),
              body: Theme(
                data: contentTheme,
                child: ScenarioWidget(scenario: scenario),
              ),
            );
          },
        ));
      },
    );
  }
}
