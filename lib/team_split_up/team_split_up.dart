import 'package:flutter/material.dart';

import 'fliter_screen.dart';
import 'teams_screen.dart';

class TeamSplitUp extends StatefulWidget {
  const TeamSplitUp({Key key}) : super(key: key);

  @override
  _TeamSplitUpState createState() => _TeamSplitUpState();
}

class _TeamSplitUpState extends State<TeamSplitUp>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FliterScreen(),
            TeamsScreen(),
          ],
        ),
      ),
    );
  }
}
