import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';
import 'package:http/http.dart' as http;

class FoodMainPage extends StatefulWidget {
  const FoodMainPage({Key? key}) : super(key: key);

  @override
  _FoodMainPageState createState() => _FoodMainPageState();
}

class _FoodMainPageState extends State<FoodMainPage> {
  var _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // FloatingActionButton
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Your Order',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          //when you press bottom it will send index to this
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _test,
        child: Icon(Icons.add),
      ),
      body: _selectedBottomNavIndex == 0
          ? FoodListPage()
          : Container(
              child: Center(
                child: Text('YOUR ORDER',
                    style: Theme.of(context).textTheme.headline1),
              ),
            ),
    );
  }
}

Future<void> _test() async {
  var url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
  var response = await http.get(
      url); //get will send back obj.type future so it's use time called asynchronous
  if (response.statusCode == 200) {
    //ดึงต่า response.body ออกมา
    Map<String, dynamic> jsonBody = json.decode(response.body);
    String status = jsonBody['status'];
    String? message = jsonBody['message'];
    List<dynamic> data = jsonBody['data'];
    print('STATUS: $status');
    print('MESSAGE: $message');
    //print('DATA: $data');
    data.forEach((element) {
      print('ITEM : $element');
      print(element['name']);
      print(element['price']);
      /*
      FoodItem(
        id:element['id'],
        name:element['name'],
        price :element['price'],
        image: element['image'],
      );
      data.map((element) => FoodItem(
        id:element['id'],
        name:element['name'],
        price :element['price'],
        image: element['image'],
      ));
      */
    });
  }
}
