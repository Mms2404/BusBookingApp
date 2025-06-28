// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travels/core/colors.dart';
import 'package:travels/core/constants.dart';

class SeatPlanView extends StatelessWidget {
  final int totalSeat;
  final String bookedSeatNumbers;
  final int totalSeatBooked;
  final bool isBusinessClass;
  final Function(bool,String) onSeatSelected;

  const SeatPlanView({
    Key? key,
    required this.totalSeat,
    required this.bookedSeatNumbers,
    required this.totalSeatBooked,
    required this.isBusinessClass,
    required this.onSeatSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noOfRows = (isBusinessClass ? totalSeat /3 : totalSeat/4).toInt();
    final noOfColumns = isBusinessClass ? 3 : 4;
    List<List<String>> seatArrangement = [];
    for (int i = 0 ; i < noOfRows; i++){
      List<String> columns = [];
      for(int j =0 ; j < noOfColumns ; j++ ){
        columns.add('${seatLabelList[i]}${j+1}');
      }
      seatArrangement.add(columns);
    }
    final List<String> bookedSeatList = bookedSeatNumbers.isEmpty 
    ? [] : bookedSeatNumbers.split(',');

    return Container(
      width: MediaQuery.of(context).size.width* 0.8,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey , width: 2)
      ),
      child: Column(
        children: [
          Text("FRONT" , style: TextStyle(color: Colors.black),),
          Divider(height: 2,color: Colors.black,),
          Column(
            children: [
              for (int i = 0 ; i < seatArrangement.length ; i++)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for(int j = 0 ;j<seatArrangement[i].length ; j++ )
                          Row(
                            children: [
                              Seat(
                                label: seatArrangement[i][j], 
                                isBooked: bookedSeatList.contains(seatArrangement[i][j]), 
                                onSelect: (value){
                                  onSeatSelected(value , seatArrangement[i][j]);
                                  }
                                ),
                                if(isBusinessClass && j==0)
                                    SizedBox(width: 25,),
                                if(!isBusinessClass && j==1)
                                    SizedBox(width: 25,)
                            ],
                          )
                    ],
                  )
            ],
          )
        ],
      ),
    );
    
  }
}



// individual seat container 

class Seat extends StatefulWidget {
  final String label;
  final bool isBooked;
  final Function(bool) onSelect;

  const Seat({
    Key? key,
    required this.label,
    required this.isBooked,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isBooked
                 ? null
                 :(){
                  setState(() {
                    selected =!selected;
                  });
                  widget.onSelect(selected);
                 },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isBooked 
              ? seatBookedColor 
              : selected 
                  ? seatSelectedColor 
                  : seatAvailableColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: widget.isBooked ? null : [
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 5,
              spreadRadius: 2
            ),
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(4, 4),
              blurRadius: 5,
              spreadRadius: 2
            )
          ]
        ),
        child: Text(widget.label,
         style: TextStyle(color: widget.isBooked 
                 ? Colors.white 
                 : selected 
                     ? Colors.white 
                     : Colors.grey,
          fontWeight: FontWeight.bold),
         ),
      ),
    );
  }
}
