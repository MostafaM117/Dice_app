import 'dart:math';

import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List <int> _diceValues = [6];
  int _numberOfDice = 1;
  
  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener((){
      setState(() {
        _diceValues = List.generate(
          _numberOfDice,(index)=> Random().nextInt(6)+ 1);
      });
    })..addStatusListener((status){
      if (status == AnimationStatus.completed){
        setState(() {
          _diceValues = List.generate(
            _numberOfDice,(index)=> Random().nextInt(6)+ 1);
        });
      }
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  void _rollDice(){
    _controller.reset();
    _controller.forward();
  }
  void _setNumberOfDice(int numberOfDice){
    setState(() {
      _numberOfDice = numberOfDice;
      _diceValues = List.generate(numberOfDice, (index)=>1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Rolling Dice",
          style: TextStyle(fontWeight: FontWeight.bold),)
        ),
      ),
      body: 
        Padding(padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            _numberOfDice == 1 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              _diceValues.map(
              (value)=>Transform.rotate(
              angle: _controller.value * 3 * pi,
              child: Image.asset('assets/dice$value.png', width: 100, height: 100,),
              )).toList(),
            ): Column(
              children:
              _diceValues.map(
              (value)=>Padding(
                padding: const EdgeInsets.all(14.0),
                child: Transform.rotate(
                angle: _controller.value * 3 * pi,
                child: Image.asset('assets/dice$value.png', width: 100, height: 100,),
                ),
              )).toList(),
            ),
            
            const SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){
                        _setNumberOfDice(1);
                        _rollDice();
                      },
                      label: const Icon(DiceIcons.dice1)),
                  const Text("1 Dice",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
                  const SizedBox(
                    width: 30,
                  ),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){
                        _setNumberOfDice(2);
                        _rollDice();
                      },
                      label: const Icon(DiceIcons.dice2)),
                  const Text("2 Dice",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
                  const SizedBox(
                    width: 30,
                  ),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){
                        _setNumberOfDice(3);
                        _rollDice();
                      },
                      label: const Icon(DiceIcons.dice3)),
                  const Text("3 Dice",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ],
        ),),
    );
  }
}