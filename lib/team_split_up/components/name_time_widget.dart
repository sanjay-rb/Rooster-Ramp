import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooster_team_splitup/model_provider/team_provider.dart';

class BuildNameAndTimeWidget extends StatelessWidget {
  final int index;
  const BuildNameAndTimeWidget({
    @required this.index,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<TeamProvider>(
      builder: (context, teamProvider, child) => Positioned(
        left: 0,
        child: Container(
          width: ((screenSize.width * 0.3) * 1.0) * 0.5,
          height: (screenSize.height * 0.5) * 0.3,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    teamProvider.teamList[index]['name'],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${teamProvider.teamList[index]['fromTime']} - ${teamProvider.teamList[index]['toTime']}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
