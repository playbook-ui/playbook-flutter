import 'package:flutter/material.dart';
import 'package:playbook/playbook.dart';

import 'component/component.dart';

class ScenarioContainer extends StatelessWidget {
  const ScenarioContainer({
    Key? key,
    required this.scenario,
  }) : super(key: key);

  final Scenario scenario;

  // TODO(mao): consider a better way to decide this number
  static const _scale = 0.3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thumbnailSize = size * _scale;
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
                          scale: _scale,
                          child: Align(
                            alignment: scenario.alignment,
                            child: HeroMode(
                              // Because we may have multiple heroes that share the same tag
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
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) {
            return DialogScaffold(
              title: Text(scenario.title),
              body: ScenarioWidget(scenario: scenario),
            );
          },
        ));
      },
    );
  }
}
