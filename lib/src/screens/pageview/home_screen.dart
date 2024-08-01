import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/components/widget/glass_card.dart';

class HomePage extends StatelessWidget {
  final String userName = "OreOfe"; // Replace with dynamic user name

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GlassCard(
          sigmaX: 50,
          sigmaY: 50,
          image: Image.asset(
            'lib/assets/images/card_bg.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              title: Text('Welcome, $userName'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    _buildYourTeams(),
                    SizedBox(
                      height: 50,
                    ),
                    _buildYourRooms(),
                    _buildSectionTitle('Latest News and Updates', context),
                    _buildNewsUpdates(),
                    _buildSectionTitle('Upcoming Matches', context),
                    _buildUpcomingMatches(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Icon(
            MavicICons.chevron_right,
            size: 17,
            color: Theme.of(context).iconTheme.color!.withOpacity(.6),
          )
        ],
      ),
    );
  }

  Widget _buildYourTeams() {
    return Container(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMatchCard('Team A vs Team B', 'Live'),
          _buildMatchCard('Team C vs Team D', 'Upcoming'),
        ],
      ),
    );
  }

  Widget _buildMatchCard(String match, String status) {
    return Container(
      width: 230,
      height: 280,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white.withOpacity(.3)
          ), borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Live', style: TextStyle(fontSize: 12))),
              ],
            ),

            //TEam Logos
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/madrid.png',
                    width: 60,
                  ),
                  Text(
                    '-',
                    style: TextStyle(fontSize: 32),
                  ),
                  Image.asset(
                    'lib/assets/images/chelsea.png',
                    width: 60,
                  )
                ],
              ),
            ),

            SizedBox(height: 8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Real Madrdid'),
                    Text('0'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chelsea',
                    ),
                    Text('0'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYourRooms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Active Rooms',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _buildRoomCard('Chelsea vs Madrid'),
        //_buildRoomCard('Room 2: Match B'),
      ],
    );
  }

  Widget _buildRoomCard(String room) {
    return SizedBox(
      width: 500,
      height: 150,
      child: GlassCard(
        sigmaX: 5,
        sigmaY: 5,
        child: Container(
          margin: EdgeInsets.all(8),
          child: Container(
            alignment: Alignment.bottomLeft,
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text(room),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsUpdates() {
    return Column(
      children: [
        _buildNewsCard('Latest News Article 1'),
        _buildNewsCard('Latest News Article 2'),
      ],
    );
  }

  Widget _buildNewsCard(String news) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(news),
      ),
    );
  }

  Widget _buildUpcomingMatches() {
    return Column(
      children: [
        _buildMatchCard('Team A vs Team B', 'Upcoming'),
        _buildMatchCard('Team C vs Team D', 'Upcoming'),
      ],
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home'),
          _buildNavItem(Icons.score, 'Scores'),
          _buildNavItem(Icons.schedule, 'Fixtures'),
          _buildNavItem(Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        Text(label),
      ],
    );
  }
}
