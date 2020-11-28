import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooster_team_splitup/model_provider/team_provider.dart';

import 'components/name_time_widget.dart';
import 'components/task_roster_widget.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({
    Key key,
  }) : super(key: key);

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen>
    with TickerProviderStateMixin {
  Map warpMap;

  List<Map> warpList;
  AnimationController _controller;
  Animation _filterAnimation;
  bool _isFilterOpen;

  @override
  void initState() {
    warpMap = {};
    warpList = [];
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _filterAnimation = Tween(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic,
        reverseCurve: Curves.easeOutCubic,
      ),
    );
    _isFilterOpen = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<TeamProvider>(
      builder: (context, teamProvider, child) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Positioned(
          left: 0,
          child: Container(
            width: screenSize.width * _filterAnimation.value,
            height: screenSize.height,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Staff and Team Restructuring'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          showDialog(
                              context: context,
                              child: Dialog(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Supervisor"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 50,
                                              height: 40,
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Operator"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 50,
                                              height: 40,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Worker"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 50,
                                              height: 40,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Driver"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 50,
                                              height: 40,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _controller,
                        ),
                        onPressed: () {
                          _isFilterOpen
                              ? _controller.reverse()
                              : _controller.forward();
                          _isFilterOpen = !_isFilterOpen;
                        },
                      ),
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        children: List.generate(
                          teamProvider.teamList.length,
                          (index) => Card(
                            child: DragTarget<Map>(
                              onAccept: (data) {
                                setState(() {
                                  warpList.add({index: data});
                                  switch (data['type']) {
                                    case 'supervisor':
                                      teamProvider.teamList[index]
                                          ['supervisorRoster']++;
                                      break;
                                    case 'operator':
                                      teamProvider.teamList[index]
                                          ['operatorRoster']++;
                                      break;
                                    case 'worker':
                                      teamProvider.teamList[index]
                                          ['workerRoster']++;
                                      break;
                                    case 'driver':
                                      teamProvider.teamList[index]
                                          ['driverRoster']++;
                                      break;
                                  }
                                });
                              },
                              builder: (context, candidateData, rejectedData) =>
                                  Container(
                                width: screenSize.width * 0.3,
                                height: screenSize.height * 0.5,
                                child: Column(
                                  children: [
                                    Container(
                                      width: (screenSize.width * 0.3) * 1.0,
                                      height: (screenSize.height * 0.5) * 0.3,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          BuildNameAndTimeWidget(
                                            index: index,
                                          ),
                                          BuildTaskAndRosterTimeWidget(
                                            index: index,
                                            paddingSpace: 1.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                          child: SingleChildScrollView(
                                        child: Wrap(
                                            children: List.generate(
                                          warpList.length,
                                          (val) {
                                            if (warpList[val][index] != null) {
                                              Color staffColor;
                                              switch (warpList[val][index]
                                                  ['type']) {
                                                case 'supervisor':
                                                  staffColor = Colors.purple;
                                                  break;
                                                case 'operator':
                                                  staffColor = Colors.blue;
                                                  break;
                                                case 'worker':
                                                  staffColor = Colors.green;
                                                  break;
                                                case 'driver':
                                                  staffColor = Colors.yellow;
                                                  break;
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        ClipOval(
                                                          child: Container(
                                                            color: staffColor,
                                                            width: 75,
                                                            height: 75,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: ClipOval(
                                                                child: Image.network(
                                                                    warpList[val]
                                                                            [
                                                                            index]
                                                                        [
                                                                        'image']),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        warpList[val][index]
                                                                        ['name']
                                                                    .toString()
                                                                    .length >
                                                                9
                                                            ? Text(
                                                                warpList[val][index]
                                                                            [
                                                                            'name']
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            9) +
                                                                    "...",
                                                              )
                                                            : Text(
                                                                warpList[val][
                                                                            index]
                                                                        ['name']
                                                                    .toString(),
                                                              ),
                                                      ],
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Icon(
                                                        Icons.brightness_1,
                                                        color: warpList[val]
                                                                    [index]
                                                                ['isCheckIn']
                                                            ? Colors.green
                                                            : Colors.red,
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                            return Container(
                                              width: 0,
                                              height: 0,
                                              color: Colors.transparent,
                                            );
                                          },
                                        )),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
