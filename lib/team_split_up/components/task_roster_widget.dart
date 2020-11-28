import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooster_team_splitup/model_provider/team_provider.dart';

class BuildTaskAndRosterTimeWidget extends StatelessWidget {
  final int index;
  const BuildTaskAndRosterTimeWidget({
    @required this.index,
    Key key,
    @required this.paddingSpace,
  }) : super(key: key);

  final double paddingSpace;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<TeamProvider>(
      builder: (context, teamProvider, child) => Positioned(
        right: 0,
        child: Container(
          width: ((screenSize.width * 0.3) * 1.0) * 0.45,
          height: (screenSize.height * 0.5) * 0.3,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRosterTeam(
                context,
                teamProvider: teamProvider,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Handeling Flight Name',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildRosterTeam(
    BuildContext context, {
    TeamProvider teamProvider,
  }) {
    Size _circleSize = Size(40, 40);
    TextStyle _circleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    TextStyle _circleNotFillStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.red,
    );
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(paddingSpace),
              child: Tooltip(
                message:
                    '${teamProvider.teamList[index]['supervisorRoster']} / ${teamProvider.teamList[index]['supervisorTask']} Supervisors',
                child: ClipOval(
                  child: Container(
                    width: _circleSize.width,
                    height: _circleSize.height,
                    color: Colors.purple,
                    child: Center(
                      child: Text(
                        '${teamProvider.teamList[index]['supervisorRoster']} / ${teamProvider.teamList[index]['supervisorTask']}',
                        style: teamProvider.teamList[index]
                                        ['supervisorRoster'] -
                                    teamProvider.teamList[index]
                                        ['supervisorTask'] ==
                                0
                            ? _circleStyle
                            : _circleNotFillStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingSpace),
              child: Tooltip(
                message:
                    '${teamProvider.teamList[index]['operatorRoster']} / ${teamProvider.teamList[index]['operatorTask']} Operators',
                child: ClipOval(
                  child: Container(
                    width: _circleSize.width,
                    height: _circleSize.height,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        '${teamProvider.teamList[index]['operatorRoster']} / ${teamProvider.teamList[index]['operatorTask']}',
                        style: teamProvider.teamList[index]['operatorRoster'] -
                                    teamProvider.teamList[index]
                                        ['operatorTask'] ==
                                0
                            ? _circleStyle
                            : _circleNotFillStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingSpace),
              child: Tooltip(
                message:
                    '${teamProvider.teamList[index]['workerRoster']} / ${teamProvider.teamList[index]['workerTask']} Workers',
                child: ClipOval(
                  child: Container(
                    width: _circleSize.width,
                    height: _circleSize.height,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        '${teamProvider.teamList[index]['workerRoster']} / ${teamProvider.teamList[index]['workerTask']}',
                        style: teamProvider.teamList[index]['workerRoster'] -
                                    teamProvider.teamList[index]
                                        ['workerTask'] ==
                                0
                            ? _circleStyle
                            : _circleNotFillStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingSpace),
              child: Tooltip(
                message:
                    '${teamProvider.teamList[index]['driverRoster']} / ${teamProvider.teamList[index]['driverTask']} Drivers',
                child: ClipOval(
                  child: Container(
                    width: _circleSize.width,
                    height: _circleSize.height,
                    color: Colors.yellow,
                    child: Center(
                      child: Text(
                        '${teamProvider.teamList[index]['driverRoster']} / ${teamProvider.teamList[index]['driverTask']}',
                        style: teamProvider.teamList[index]['driverRoster'] -
                                    teamProvider.teamList[index]
                                        ['driverTask'] ==
                                0
                            ? _circleStyle
                            : _circleNotFillStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
