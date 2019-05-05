import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sales_mgmt/constants.dart';
import 'package:sales_mgmt/screens/goal_screen.dart';
import 'package:sales_mgmt/screens/profile_screen.dart';
import 'package:sales_mgmt/screens/stats_screen.dart';
import 'package:sales_mgmt/screens/team_screen.dart';
import 'package:sales_mgmt/bloc/app_bloc_provider.dart';

class Dashboard extends StatefulWidget {
  final List<Widget> _pages = [
    GoalScreen(),
    StatsScreen(),
    TeamScreen(),
    ProfileScreen(),
  ];

  final TextEditingController _controller = TextEditingController();
  final PageController _pageController = PageController();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selection = 0;
  AppBloc appBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    appBloc = AppBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    appBloc.dispose();
    widget._pageController.dispose();
    widget._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: selection == 3 ? 160 : 0,
              floating: true,
              pinned: true,
              snap: true,
              centerTitle: selection == 0,
              // title: getTitle(),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/image1.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: getBody(),
      ),
      bottomNavigationBar: BubbleBottomBar(
        currentIndex: selection,
        opacity: .2,
        items: [
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.red,
            ),
            title: Text("GOAL"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.timer,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.timer,
              color: Colors.deepPurple,
            ),
            title: Text("My STATS"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.translate,
              color: Colors.black,
            ),
            activeIcon: Icon(Icons.translate, color: Colors.indigo),
            title: Text("TEAM"),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
            activeIcon: Icon(Icons.calendar_today, color: Colors.green),
            title: Text("PROFILE"),
          ),
        ],
        onTap: (index) {
          setState(() {
            selection = index;
          });
          widget._pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
    );
  }

  Widget getBody() {
    return Center(child: getTitle());
    // return PageView(
    //   children: widget._pages,
    //   pageSnapping: true,
    //   controller: widget._pageController,
    //   onPageChanged: (int index) {
    //     setState(() {
    //       selection = index;
    //     });
    //   },
    // );
  }

  Widget getTitle() {
    print("gettitle $selection");
    switch (selection) {
      case 0:
        return TextField(
          decoration: InputDecoration.collapsed(hintText: "Your Goal"),
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.words,
          controller: widget._controller,
        );
        break;

      case 1:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder<String>(
              stream: appBloc.statsMonth,
              initialData: "Baisakh",
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  print("no data snapshot of stats is ${snapshot.data}");
                print("snapshot of stats is ${snapshot.data}");

                return DropdownButton<String>(
                  value: snapshot.data,
                  items: months
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: (selectedM) {
                    print("onchange from stats");
                    appBloc.selectStatMonth(selectedM);
                  },
                );
              },
            ),
            Text("Time Frame"),
          ],
        );
        break;

      case 3:
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder<String>(
              stream: appBloc.demo,
              initialData: "1",
              builder: (context, snapshot) {
                print("snapshot of teams ${snapshot.data}");
                if (snapshot.data == null) {
                  return Container();
                }
                return DropdownButton<String>(
                  value: snapshot.data,
                  items: ["1", "2", "3", "4", "team1", "team2", "team3"]
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: (teamN) {
                    print("onchange from team name");

                    appBloc.selectInt(teamN);
                  },
                );
              },
            ),
            StreamBuilder<String>(
              stream: appBloc.teamsMonth,
              initialData: "Baisakh",
              builder: (context, snapshot) {
                print("snapshot of month ${snapshot.data}");
                return DropdownButton<String>(
                  value: snapshot.data,
                  items: months
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: (selectedM) {
                    print("onchange from month team");

                    appBloc.selectTeamMonth(selectedM);
                  },
                );
              },
            ),
          ],
        );
        break;

      default:
        return Container();
        break;
    }
  }

  userProfileInfo() {
    return Column(
      children: <Widget>[
        Align(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text("Name"),
          ),
          alignment: Alignment.topLeft,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/image1.jpeg"),
            backgroundColor: Colors.transparent,
          ),
        )
      ],
    );
  }
}
