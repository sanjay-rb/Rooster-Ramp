import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rooster_team_splitup/test_data/test_data.dart';

class FliterScreen extends StatefulWidget {
  const FliterScreen({
    Key key,
  }) : super(key: key);

  @override
  _FliterScreenState createState() => _FliterScreenState();
}

class _FliterScreenState extends State<FliterScreen> {
  List displayList;
  var radioSelected;
  String checkInTime, checkOutTime;
  String staffName;

  @override
  void initState() {
    staffName = null;
    displayList = staffData;
    checkInTime = "Check In Time";
    checkOutTime = "Check Out Time";
    radioSelected = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      child: Container(
        width: screenSize.width * 0.3,
        height: screenSize.height,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildRadioFilter(),
                    buildTimeFliter(context),
                    buildNameFliter(),
                  ],
                ),
              ),
            ),
            Divider(
              endIndent: 50,
              indent: 50,
              thickness: 2,
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, index) => Draggable<Map>(
                      data: displayList[index],
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: buildStaffCards(screenSize, index),
                      ),
                      feedback: Transform.scale(
                        scale: 0.8,
                        child: buildStaffCards(screenSize, index),
                      ),
                      child: buildStaffCards(screenSize, index),
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

  Padding buildNameFliter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Search'),
        onChanged: (value) {
          setState(() {
            if (radioSelected == -1) {
              displayList = staffData
                  .where((element) => element['name']
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            } else {
              String selectDest =
                  ['supervisor', 'operator', 'worker', 'driver'][radioSelected];
              displayList = staffData
                  .where((element) => (element['name']
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()) &&
                      element['type'] == selectDest))
                  .toList();
            }
          });
        },
      ),
    );
  }

  ToggleButtons buildTimeFliter(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) {
        if (index == 0) {
          showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
            (value) {
              if (value != null) {
                setState(() {
                  checkInTime =
                      "Check In Time : ${value.hour}:${value.minute}" ??
                          checkInTime;
                });
              }
            },
          );
        } else {
          showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
            (value) {
              if (value != null) {
                setState(() {
                  checkOutTime =
                      "Check Out Time : ${value.hour}:${value.minute}" ??
                          checkOutTime;
                });
              }
            },
          );
        }
      },
      color: Colors.black,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(checkInTime),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(checkOutTime),
        ),
      ],
      isSelected: [false, false],
    );
  }

  Padding buildRadioFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                value: -1,
                groupValue: radioSelected,
                onChanged: (value) {
                  setState(() {
                    radioSelected = value;
                    displayList = staffData;
                  });
                },
              ),
              InkWell(child: Text('All'))
            ],
          ),
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: radioSelected,
                onChanged: (value) {
                  setState(() {
                    radioSelected = value;
                    displayList = staffData
                        .where((element) => element['type'] == 'supervisor')
                        .toList();
                  });
                },
              ),
              InkWell(child: Text('Supervisor'))
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: radioSelected,
                onChanged: (value) {
                  setState(() {
                    radioSelected = value;
                    setState(() {
                      radioSelected = value;
                      displayList = staffData
                          .where((element) => element['type'] == 'operator')
                          .toList();
                    });
                  });
                },
              ),
              Text('Operator')
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: radioSelected,
                onChanged: (value) {
                  setState(() {
                    radioSelected = value;
                    setState(() {
                      radioSelected = value;
                      displayList = staffData
                          .where((element) => element['type'] == 'worker')
                          .toList();
                    });
                  });
                },
              ),
              Text('Worker')
            ],
          ),
          Row(
            children: [
              Radio(
                value: 3,
                groupValue: radioSelected,
                onChanged: (value) {
                  setState(() {
                    radioSelected = value;
                    setState(() {
                      radioSelected = value;
                      displayList = staffData
                          .where((element) => element['type'] == 'driver')
                          .toList();
                    });
                  });
                },
              ),
              Text('Driver')
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStaffCards(Size screenSize, int index) {
    Color staffColor;
    switch (displayList[index]['type']) {
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
    return Stack(
      children: [
        Card(
          child: Container(
            width: screenSize.width * 0.25,
            height: 150,
            color: staffColor,
          ),
        ),
        Card(
          child: Container(
            width: screenSize.width * 0.23,
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(displayList[index]['image']),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Tooltip(
                                message: displayList[index]['name'],
                                preferBelow: false,
                                child: displayList[index]['name']
                                            .toString()
                                            .length >
                                        9
                                    ? Text(
                                        displayList[index]['name']
                                                .toString()
                                                .substring(0, 9) +
                                            "...",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    : Text(
                                        displayList[index]['name'].toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ),
                              Expanded(child: Container()),
                              ...getIcons(index),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                displayList[index]['type'],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.brightness_1,
                                color: displayList[index]['isCheckIn']
                                    ? Colors.green
                                    : Colors.red,
                                size: 15,
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '100',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'data',
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '100',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'data',
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '100',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'data',
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getIcons(index) {
    return [
      Icon(
        displayList[index]['rate'] >= 1 ? Icons.star : Icons.star_border,
        size: 15,
      ),
      Icon(
        displayList[index]['rate'] >= 2 ? Icons.star : Icons.star_border,
        size: 15,
      ),
      Icon(
        displayList[index]['rate'] >= 3 ? Icons.star : Icons.star_border,
        size: 15,
      ),
      Icon(
        displayList[index]['rate'] >= 4 ? Icons.star : Icons.star_border,
        size: 15,
      ),
      Icon(
        displayList[index]['rate'] >= 5 ? Icons.star : Icons.star_border,
        size: 15,
      ),
    ];
  }
}
