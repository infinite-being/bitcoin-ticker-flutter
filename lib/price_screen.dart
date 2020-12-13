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
            currentPrice = List();
            getCurrentPrice(selectedCurrency);
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
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          currentPrice = List();
          getCurrentPrice(selectedCurrency);
        });
      },
      children: pickerList,
    );
  }

  List<int> currentPrice = List();
  @override
  void initState() {
    super.initState();
    getCurrentPrice('usd');
  }

  void getCurrentPrice(String currency) async {
    CoinData coinData = CoinData();
    var prices = await coinData.getCoinData(currency.toLowerCase());
    setState(() {
      currentPrice = prices;
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        currentPrice.isNotEmpty
                            ? '1 ${cryptoList[0]} = ${currentPrice[0]} $selectedCurrency'
                            : '1 ${cryptoList[0]} = ? $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        currentPrice.isNotEmpty
                            ? '1 ${cryptoList[1]} = ${currentPrice[1]} $selectedCurrency'
                            : '1 ${cryptoList[1]} = ? $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        currentPrice.isNotEmpty
                            ? '1 ${cryptoList[2]} = ${currentPrice[2]} $selectedCurrency'
                            : '1 ${cryptoList[2]} = ? $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
            // child: iosPicker(),
          ),
        ],
      ),
    );
  }
}
