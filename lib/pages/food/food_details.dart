import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';

import 'food_list_page.dart';

class FoodDetails extends StatefulWidget {
  static var routeName = '/detail';

  const FoodDetails({Key? key}) : super(key: key);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FoodItem;
    return Scaffold(
      appBar: AppBar(
        title: Text((args.name),style: GoogleFonts.prompt(fontSize: 24.0),),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.asset(
              'assets/images/${args.image}',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(('ชื่อเมนู: '+args.name),style: GoogleFonts.prompt(fontSize: 18.0),),
                  Text(('ราคา: '+args.price.toString()+' บาท'),style: GoogleFonts.prompt(fontSize: 18.0),),
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
