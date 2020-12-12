import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> dropDownMenuItems = List();
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownMenuItems.add(newItem);
    }

    return DropdownButton(
        items: dropDownMenuItems,
        value: selectedCurrency,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerList = List();
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerList.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerList,
    );
  }

  int currentPrice = 0;
  @override
  void initState() {
    super.initState();
    getCurrentPrice();
  }

  void getCurrentPrice() async {
    CoinData coinData = CoinData();
    double price = await coinData.getCoinData('bitcoin', 'usd');
    setState(() {
      currentPrice = price.round();
    });
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
                  '1 BTC = $currentPrice USD',
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
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
