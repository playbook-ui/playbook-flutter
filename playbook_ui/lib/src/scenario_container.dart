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
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 6),
              ],
            ),
            child: Card(
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
                                data: ThemeProvider.of(context).theme,
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
          ),
          const SizedBox(height: 8),
          Container(
            width: thumbnailSize.width,
            alignment: Alignment.center,
            child: Text(
              scenario.title,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).textTheme.headline3?.color,
                  ),
            ),
          ),
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) {
            return DialogScaffold(
              title: Text(
                scenario.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              body: Theme(
                data: ThemeProvider.of(context).theme,
                child: Align(
                  alignment: scenario.alignment,
                  child: scenario.child,
                ),
              ),
            );
          },
        ));
      },
    );
  }
}
