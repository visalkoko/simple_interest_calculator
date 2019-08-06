import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['khmer', 'ruppe', 'english'];
  final _minimumPadding = 5.0;
  var _currencySelected = '';

  var _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currencySelected = _currencies[0];
  }

  TextEditingController principleController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Welcome to interest App!"),
      ),
      body: Form(
        key: _fromKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      controller: principleController,
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your priciple';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'Principle',
                          errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                          hintText: 'Enter the principle e.g 1200',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.5))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      controller: roiController,
                      style: textStyle,
                      validator: (String value){
                        if (value.isEmpty){
                          return 'please enter ROI';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.yellowAccent
                          ),
                          hintText: 'In percent',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.5))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          controller: termController,
                          style: textStyle,
                          validator: (String value){
                            if (value.isEmpty){
                              return 'please enter term';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Term',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              hintText: 'Time in years',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.5))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currencySelected,
                          onChanged: (String newValueSelected) {
                            _newDropDownItemSelected(newValueSelected);
                          },
                        )),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              child: Text(
                                'Calculate',
                                textScaleFactor: 1.5,
                              ),
                              textColor: Theme.of(context).primaryColorDark,
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                setState(() {
                                  if (_fromKey.currentState.validate()) {
                                    this.displayResult =
                                        _calculateTotalReturn();
                                  }
                                });
                              }),
                        ),
                        Expanded(
                          child: RaisedButton(
                              child: Text(
                                'Reset',
                                textScaleFactor: 1.5,
                              ),
                              textColor: Theme.of(context).primaryColorLight,
                              color: Theme.of(context).primaryColorDark,
                              onPressed: () {
                                _reset();
                              }),
                        )
                      ],
                    )),
                Padding(
                    child: Text(
                      this.displayResult,
                      style: textStyle,
                    ),
                    padding: EdgeInsets.all(_minimumPadding * 2))
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/somjot.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _newDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currencySelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmount = principle + (principle * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmount $_currencySelected';
    return result;
  }

  void _reset() {
    principleController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currencySelected = _currencies[0];
  }
}
