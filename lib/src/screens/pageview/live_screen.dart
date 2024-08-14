import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/components/widget/custom_button.dart';
import 'package:truck/src/components/widget/glass_card.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/models/fixture_model.dart';
import 'package:truck/src/screens/matchDetails/match_details_screen.dart';
import 'package:truck/src/themes/light_theme.dart';

class LiveMatchesScreen extends StatefulWidget {
  @override
  _LiveMatchesScreenState createState() => _LiveMatchesScreenState();
}

class _LiveMatchesScreenState extends State<LiveMatchesScreen> {
  final PageController _pageController = PageController(initialPage: 6);
  final ScrollController _scrollController = ScrollController();
  List<DateTime> _dates = List.generate(
      14,
      (index) => DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 6 - index)));
  int _currentIndex = 6;
  bool poppupIsActive = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(_currentIndex);
    });
  }

  void _pageListener() {
    setState(() {
      _currentIndex = _pageController.page?.round() ?? 6;
    });

    if (_pageController.page! >= _dates.length - 1) {
      setState(() {
        _dates.addAll(List.generate(
            7, (index) => _dates.last.add(Duration(days: index + 1))));
      });
    }

    if (_pageController.page! <= 0) {
      setState(() {
        _dates.insertAll(
            0,
            List.generate(7,
                (index) => _dates.first.subtract(Duration(days: 7 - index))));
        _pageController.jumpToPage(7);
      });
    }

    _scrollToCenter(_currentIndex);

    if (poppupIsActive && _currentIndex - 6 <= 5) {
      setState(() {
        poppupIsActive = false;
      });
    }

    if (!poppupIsActive && (_currentIndex - 6 > 5)) {
      setState(() {
        poppupIsActive = true;
      });
    }
  }

  void _scrollToCenter(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double screenWidth = MediaQuery.of(context).size.width;
      double containerWidth = screenWidth / 5.3;

      double scrollPosition =
          containerWidth * index - (screenWidth / 2 - containerWidth / 2);

      _scrollController.animateTo(
        scrollPosition,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _showReturnToTodayDialog() {
    setState(() {
      poppupIsActive = true;
    });
  }

  void returnToToday() {
    int todayIndex = _dates.indexWhere((date) =>
        date ==
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
    _pageController.jumpToPage(todayIndex);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    _scrollController.dispose();
    _fixturesBloc.close();
    super.dispose();
  }

  final Map<DateTime, ApiResponse> _cache = {};
  late FixturesBloc _fixturesBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FixturesBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  MavicICons.calendar_week,
                  size: 28,
                ))
          ],
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: _buildDateNav(),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                DateTime date = _dates[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(8.0),
                  child: _buildMatchDayPage(date),
                );
              },
            ),
            AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                bottom: poppupIsActive ? 0 : -50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: poppupIsActive ? 1 : 0,
                  curve: Curves.fastOutSlowIn,
                  child: SizedBox(
                    height: 50,
                    child: CustomButton(
                        text: 'Today',
                        buttonType: ButtonType.elevated,
                        onPressed: () {
                          setState(() {
                            poppupIsActive = false;
                          });
                          returnToToday();
                        }),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Widget _buildDateNav() {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_dates.length, (index) {
          DateTime date = _dates[index];
          String formattedDate = DateFormat('MMM d').format(date);
          if (calculateDifference(date) == 0) {
            formattedDate = 'Today';
          } else if (calculateDifference(date) == -1) {
            formattedDate = 'Yesterday';
          } else if (calculateDifference(date) == 1) {
            formattedDate = 'Tomorrow';
          }

          return InkWell(
            onTap: () {
              _pageController.jumpToPage(index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? const Color.fromRGBO(75, 59, 137, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    Text(
                      DateFormat('E').format(date),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodySmall!.color!),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat('d').format(date),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodySmall!.color!),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Map<String, List<Data>> groupFixturesByLeague(ApiResponse apiResponse) {
    final Map<String, List<Data>> groupedFixtures = {};

    for (var fixtureResponse in apiResponse.data) {
      final leagueName = fixtureResponse.league!.name!;

      if (groupedFixtures.containsKey(leagueName)) {
        if (groupedFixtures[leagueName]!.length < 10) {
          groupedFixtures[leagueName]!.add(fixtureResponse);
        }
      } else {
        groupedFixtures[leagueName] = [fixtureResponse];
      }
    }

    return groupedFixtures;
  }

  Widget _buildMatchDayPage(DateTime date) {
    _fixturesBloc = FixturesBloc();

    return BlocBuilder<FixturesBloc, FixturesState>(
      bloc: _fixturesBloc,
      builder: (context, state) {
        if (state is FixtureInitial) {
          // Check cache first
          if (_cache.containsKey(date)) {
            return _buildFixturesPage(_cache[date]!);
          } else {
            _fixturesBloc.add(FetchFixtures(date));
            return Center(child: CircularProgressIndicator());
          }
        } else if (state is FixturesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FixturesLoaded) {
          // Cache the response
          _cache[date] = state.response;
          return _buildFixturesPage(state.response);
        } else if (state is FixturesError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text('Error: ${state.message}')),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('No matches for this day.')),
          );
        }
      },
    );
  }

  Widget _buildFixturesPage(ApiResponse apiResponse) {
    final groupedFixtures = groupFixturesByLeague(apiResponse);

    return ListView.builder(
      itemCount: groupedFixtures.keys.length,
      itemBuilder: (context, index) {
        final leagueName = groupedFixtures.keys.elementAt(index);
        final fixtures = groupedFixtures[leagueName]!;

        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 47, 51, 67),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: Theme.of(context).textTheme.bodyLarge!.color,
              initiallyExpanded: true,
              dense: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(leagueName),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(.5),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        fixtures.length.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ))
                ],
              ),
              children: fixtures.map((fixture) {
                final status = fixture.fixture!.status;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MatchDetailsScreen(response: fixture),
                      ),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF2B2E3A),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: scoreTile(fixture)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget scoreTile(Data fixture) {
    return ListTile(
      leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorDark.withOpacity(.1),
          ),
          child: Text(
            fixture.fixture!.status!.short!,
            style: TextStyle(fontSize: 12),
          )),
      title: Row(
        children: [
          //Home Ui
          Expanded(
            flex: 2,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        fixture.teams!.home['name'],
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color:
                                Theme.of(context).textTheme.bodySmall!.color),
                      )),
                  SizedBox(
                    width: 7,
                  ),
                  Image.network(
                    fixture.teams!.home['logo'],
                    width: 23,
                  )
                ],
              ),
            ),
          ),
          //Scores or Time UI
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: fixture.fixture!.status!.short == 'NS' ||
                        fixture.fixture!.status!.short == 'PST'
                    ?
                    //Time UI
                    Container(
                        child: Text(
                          DateFormat('HH:mm').format(fixture.fixture!.date!),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration:
                                  fixture.fixture!.status!.short == 'PST'
                                      ? TextDecoration.lineThrough
                                      : null,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                      )
                    :
                    //Scores UI
                    Container(
                        child: fixture.fixture!.status!.short != 'TBD' ? Text(
                            '${fixture.goals!.home} - ${fixture.goals!.away}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color)): Text(
                            '${DateFormat('hh:mm').format(fixture.fixture!.date!)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color))),
              ),
            ),
          ),
          //Away UI
          Expanded(
            flex: 2,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    fixture.teams!.away['logo'],
                    width: 23,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        fixture.teams!.away['name'],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color:
                                Theme.of(context).textTheme.bodySmall!.color),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
