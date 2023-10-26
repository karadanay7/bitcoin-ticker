import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


// ignore: use_key_in_widget_constructors
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

DropdownButton<String> androidDropdown (){

  List<DropdownMenuItem<String>> dropdownItems =[];
  for ( String currency in currenciesList) {
    var newItem=  DropdownMenuItem(value: currency,child: Text(currency),);
    dropdownItems.add(newItem);
  }
  return DropdownButton<String>(
    value: selectedCurrency,
    items: dropdownItems,

    onChanged: (value) {
      setState(() {
        selectedCurrency = value!;
        getData();
      });

    },
  );

}

  CupertinoPicker iOSPicker(){
  List<Text> pickerItems = [];
  for(String currency in currenciesList) {
    pickerItems.add(Text(currency));
  }
  return CupertinoPicker(
    backgroundColor: Colors.lightBlue,
    itemExtent: 32, onSelectedItemChanged: (selectedIndex){
    print(selectedIndex);
    setState(() {
      //1: Save the selected currency to the property selectedCurrency
      selectedCurrency = currenciesList[selectedIndex];
      //2: Call getData() when the picker/dropdown changes.
      getData();
    });
  },
    children:pickerItems ,
  );

  }

  String bitcoinValueInUSD = '?';
  String value = '?';
  //11. Create an async method here await the coin data from coin_data.dart
  void getData() async {
    try {
      double data = await CoinData().getCoinData(selectedCurrency);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        value = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $value $selectedCurrency',
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
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker(): androidDropdown(),
          ),
        ] ,
      ),
    );
  }
}
