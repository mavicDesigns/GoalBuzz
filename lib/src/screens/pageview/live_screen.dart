import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class LiveMatchesScreen extends StatefulWidget {
  @override
  _LiveMatchesScreenState createState() => _LiveMatchesScreenState();
}

class _LiveMatchesScreenState extends State<LiveMatchesScreen> {
  final PageController _pageController = PageController(initialPage: 6);
  final Map<String, _CachedData<List<Match>>> _cache = {};
  final Duration _cacheDuration = Duration(minutes: 10);
  final ScrollController _scrollController = ScrollController();

  List<DateTime> _dates = List.generate(
      14, (index) => DateTime.now().subtract(Duration(days: 6 - index)));
  int _currentIndex = 6;

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

    // Add more dates to the end
    if (_pageController.page! >= _dates.length - 1) {
      setState(() {
        _dates.addAll(List.generate(
            7, (index) => _dates.last.add(Duration(days: index + 1))));
      });
    }

    // Add more dates to the beginning
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
  }

  void _scrollToCenter(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double screenWidth = MediaQuery.of(context).size.width;
      double containerWidth = screenWidth / 4; // Adjust this value as needed
      double scrollPosition = containerWidth * index -
          (screenWidth / 2 - containerWidth / 2);
      _scrollController.animateTo(
        scrollPosition,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Matches'),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: _buildDateNav(),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          DateTime date = _dates[index];
          return _buildMatchDayPage(date);
        },
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
          String formattedDate = calculateDifference(date) == 0
              ? 'Today'
              : calculateDifference(date) == -1 ? 'Yesterday'
              : calculateDifference(date) == 1 ? 'Tomorrow'
              : DateFormat('MMM d').format(date);
          return InkWell(
            onTap: () {
              _pageController.jumpToPage(index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        width: 5,
                          color: index == _currentIndex
                              ?  Theme.of(context).cardColor
                              : Colors.transparent))),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                formattedDate,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).cardColor),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMatchDayPage(DateTime date) {
    String formattedDate = DateFormat('EEEE, MMM d').format(date);

    return FutureBuilder<List<Match>>(
      future: _fetchMatchesForDate(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No matches for this day.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Match match = snapshot.data![index];
              return ListTile(
                title: Text('${match.homeTeam} vs ${match.awayTeam}'),
                subtitle: Text('${formattedDate}'),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Match>> _fetchMatchesForDate(DateTime date) async {
    String dateKey = DateFormat('yyyy-MM-dd').format(date);
    if (_cache.containsKey(dateKey) &&
        DateTime.now().difference(_cache[dateKey]!.timestamp) <
            _cacheDuration) {
      return _cache[dateKey]!.data;
    }

    List<Match> matches =
        await _fetchMatchesFromNetwork(date); // Fetch from network
    _cache[dateKey] = _CachedData(matches, DateTime.now());
    return matches;
  }

  Future<List<Match>> _fetchMatchesFromNetwork(DateTime date) async {
    // Your logic to fetch matches for the given date
    // This is just a placeholder
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      Match(homeTeam: 'Team A', awayTeam: 'Team B', time: '12:00 PM'),
      Match(homeTeam: 'Team C', awayTeam: 'Team D', time: '3:00 PM'),
    ];
  }
}

class _CachedData<T> {
  final T data;
  final DateTime timestamp;

  _CachedData(this.data, this.timestamp);
}

class Match {
  final String homeTeam;
  final String awayTeam;
  final String time;

  Match({required this.homeTeam, required this.awayTeam, required this.time});
}
