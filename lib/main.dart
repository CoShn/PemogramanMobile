import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Helvetica-Bold',
        scaffoldBackgroundColor: Colors.black12,
      ),
      home: UnitConverter(),
      routes: {
        '/about': (context) => AboutPage(),
      },
    );
  }
}

// UNIT CONVERTER
class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String _selectedShape = 'Lingkaran';
  String _selectedUnit = 'Luas';
  double _inputValue = 0.0;
  double _outputValue = 0.0;

  final Map<String, List<String>> _shapes = {
    'Lingkaran': ['Luas', 'Keliling'],
    'Belah Ketupat': ['Luas'],
    'Layang-Layang': ['Luas'],
    'Trapesium': ['Luas'],
    'Jajar Genjang': ['Luas'],
    'Segitiga': ['Luas'],
  };

  final Map<String, IconData> shapesIcons = {
    'Lingkaran': Icons.circle_outlined,
    'Belah Ketupat': Icons.diamond_outlined,
    'Layang-Layang': Icons.star_border,
    'Trapesium': Icons.filter_4,
    'Jajar Genjang': Icons.crop_16_9,
    'Segitiga': Icons.change_history,
  };

  void _convert() {
    setState(() {
      switch (_selectedShape) {
        case 'Lingkaran':
          if (_selectedUnit == 'Area') {
            _outputValue = 3.14159 * _inputValue * _inputValue;
          } else if (_selectedUnit == 'Circumference') {
            _outputValue = 2 * 3.14159 * _inputValue;
          }
          break;
        case 'Belah Ketupat':
          _outputValue = 0.5 * _inputValue * _inputValue;
          break;
        case 'Layang-Layang':
          _outputValue = 0.5 * _inputValue * _inputValue;
          break;
        case 'Jajar Genjang':
          _outputValue = _inputValue * _inputValue;
          break;
        case 'Segitiga':
          _outputValue = 0.5 * _inputValue * _inputValue;
          break;
        default:
          _outputValue = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/unit_converter.png',
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              'Unit Converter',
              style: TextStyle(fontWeight: FontWeight.bold),
              selectionColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Pilih Bentuk',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(shape),
                              Icon(shapesIcons[shape]),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Pilih Satuan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(unit),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Nilai',
                      ),
                      onChanged: (String value) {
                        _inputValue = double.tryParse(value) ?? 0.0;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convert,
                      child: Text('Konversikan'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Hasil Nilai: $_outputValue',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MENU
class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/foto_profil.jpg'),
                  radius: 40,
                ),
                SizedBox(height: 10),
                Text(
                  'Ricardo - 20210801494',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'About',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}

// ABOUT PAGE
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Text(
          'Aplikasi ini bertujuan untuk memudahkan meng-konvert rumus bangun datar\n'
              'seperti Lingkaran, Belah Ketupat, Layang-layang, Trapesium, Jajar Genjang atau Segitiga.',
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
