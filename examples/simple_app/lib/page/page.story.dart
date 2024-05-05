import 'package:simple_app/page/page.dart';
import 'package:playbook/playbook.dart';

Story homePageStory() {
  return Story('HomePage', scenarios: [
    Scenario(
      'myPage',
      child: HomePage(title: 'Home Page'),
    ),
  ]);
}
