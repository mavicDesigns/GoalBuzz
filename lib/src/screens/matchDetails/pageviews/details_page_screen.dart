
import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView({super.key});

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _buildDetailsCard()
        ],),
      ),
    );
  }


  Widget _buildDetailsCard(){
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:  8.0),
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal:  16 ,vertical: 8),
            child: Row(children: [
              Icon(MavicICons.calendar_week, size: 16, color: Theme.of(context).iconTheme.color,),
              SizedBox(width: 10,),
              Text('Today 1:20', style: Theme.of(context).textTheme.bodySmall,)
            ],),
          ),
        
            Container(
            padding: EdgeInsets.symmetric(horizontal:  16, vertical: 8),
            child: Row(children: [
              Icon(MavicICons.globe, size: 16, color: Theme.of(context).iconTheme.color,),
              SizedBox(width: 10,),
              Text('Club Friendlies', style: Theme.of(context).textTheme.bodySmall,)
            ],),
          )
        ],),
      ),
    );
  }
}
