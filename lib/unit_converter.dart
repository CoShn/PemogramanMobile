import 'package:flutter/material.dart';
import 'drawer_menu.dart';

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String _selectedShape = 'Circle';
  String _selectedUnit = 'Area';
  double _inputValue = 0.0;
  double _outputValue = 0.0;

  final Map<String, List<String>> _shapes = {
    'Circle': ['Area', 'Circumference'],
    'Rhombus': ['Area'],
    'Kite': ['Area'],
    'Trapezoid': ['Area'],
    'Parallelogram': ['Area'],
    'Triangle': ['Area'],
  };

  void _convert() {
    setState(() {
      if (_selectedShape == 'Circle') {
        if (_selectedUnit == 'Area') {
          _outputValue = 3.14159 * _inputValue * _inputValue;
        } else if (_selectedUnit == 'Circumference') {
          _outputValue = 2 * 3.14159 * _inputValue;
        }
      }
      // Implement conversions for other shapes here...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedShape,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedShape = newValue!;
                  _selectedUnit = _shapes[_selectedShape]!.first;
                });
              },
              items: _shapes.keys.map((String shape) {
                return DropdownMenuItem<String>(
                  value: shape,
                  child: Text(shape),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _selectedUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUnit = newValue!;
                });
              },
              items: _shapes[_selectedShape]!.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Input Value',
              ),
              onChanged: (String value) {
                _inputValue = double.tryParse(value) ?? 0.0;
              },
            ),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            Text(
              'Output Value: $_outputValue',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
