import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/components/widget/glass_card.dart';
import 'package:truck/src/themes/dartk_theme.dart';

class HomePage extends StatelessWidget {
  final String userName = "OreOfe"; // Replace with dynamic user name

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: Text('Welcome, $userName'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),

                _buildTeamCard(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildSectionTitle('Live Matches', context),
                ),
                _buildYourTeams(),
                SizedBox(
                  height: 50,
                ),
                //_buildYourRooms(),
                // _buildSectionTitle('Latest News and Updates', context),
                // _buildNewsUpdates(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildSectionTitle('Upcoming Matches', context),
                ),
                _buildUpcomingMatches(),
              ],
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

  Widget _buildTeamCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
         
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary1,
                  const Color.fromRGBO(40, 62, 181, 1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: 500,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Home Ui
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/images/chelsea.png',
                        width: 70,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Chelsea')
                    ],
                  ),
                ),
          
                Text('VS'),
          
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/images/madrid.png',
                        width: 70,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Real Madrid')
                    ],
                  ),
                )
              ],
            ),
          ),
       
        Positioned(
            bottom: -10,
            left: 110,
            child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal:  10),
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF2B2E3A),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('lib/assets/images/laliga.png', width: 15,),
                Text('Today, 08:30pm', style: TextStyle(fontSize: 10),)
              ],
            ),
          )),
 ],
      ),
    );
  }

  Widget _buildYourTeams() {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMatchCard('Team A vs Team B', true),
          _buildMatchCard('Team C vs Team D', true),
        ],
      ),
    );
  }

  Widget _buildMatchCard(String match, bool status) {
    return Container(
      width: 170,
      height: 280,
      decoration: BoxDecoration(
          color: Color(0xFF2B2E3A),
        //  border: Border.all(width: 2, color: const Color.fromRGBO(75, 59, 137, 1)),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            status == true
                ? Row(
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('Live',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black))),
                    ],
                  )
                : Container(),

            //TEam Logos
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/madrid.png',
                    width: 40,
                  ),
                  Image.asset(
                    'lib/assets/images/chelsea.png',
                    width: 40,
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
        Text(
          'Active Rooms',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _buildRoomCard('Chelsea vs Madrid'),
        //_buildRoomCard('Room 2: Match B'),
      ],
    );
  }

  Widget _buildRoomCard(String room) {
    return GlassCard(
      sigmaX: 5,
      sigmaY: 5,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Container(
          alignment: Alignment.bottomLeft,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.2),
              border: Border.all(color: Colors.white.withOpacity(.3)),
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Text(room),
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
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMatchCard('Team A vs Team B', false),
          _buildMatchCard('Team C vs Team D', false),
        ],
      ),
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
