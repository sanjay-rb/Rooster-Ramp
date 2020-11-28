import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooster_team_splitup/model_provider/team_provider.dart';
import 'package:rooster_team_splitup/test_data/test_data.dart';

import 'team_split_up/team_split_up.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TeamProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.watch<TeamProvider>().teamList = teamData;
    return MaterialApp(
      title: 'Team SplitUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TeamSplitUp(),
    );
  }
}
