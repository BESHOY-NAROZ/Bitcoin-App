import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Networking networking = Networking();

  dynamic price;
  String firstValue = 'AUD';

  iosMenuCupertinoPicker() {
    List<Text> list = [];
    for (int i = 0; i < currenciesList.length; i++) {
      list.add(Text(currenciesList[i]));
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selected) {
          firstValue = currenciesList[selected];
          collectData();
          print(currenciesList[selected]);
        },
        children: list);
  }

  dynamic dropMenuAndroid() {
    List<DropdownMenuItem<dynamic>> list = [];
    DropdownButton dropdownButton;
    DropdownMenuItem dropdownItems;
    for (int i = 0; i < currenciesList.length; i++) {
      String curList = currenciesList[i];
      dropdownItems = DropdownMenuItem(
        child: Text(curList),
        value: curList,
      );
      list.add(dropdownItems);
    }
    dropdownButton = DropdownButton(
        value: firstValue,
        items: list,
        onChanged: (value) {
          firstValue = value;
          collectData();
          print(value.toString());
        });
    return dropdownButton;
  }

  collectData() async {
    price = await networking.getData(firstValue);
    print(price);
    setState(() {
      price;
      firstValue;
    });
  }

  @override
  void initState() {
    collectData();
    super.initState();
  }

  checkOSPlatform() {
    if (Platform.isAndroid) {
      return dropMenuAndroid();
    } else if (Platform.isIOS) {
      return iosMenuCupertinoPicker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $price $firstValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosMenuCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
//dropMenu()
