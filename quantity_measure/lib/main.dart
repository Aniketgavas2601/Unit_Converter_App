import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MethodCall(),
    );
  }
}

class MethodCall extends StatefulWidget {
  const MethodCall({Key? key}) : super(key: key);

  @override
  State<MethodCall> createState() => _MethodCallState();
}

class _MethodCallState extends State<MethodCall> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("UniConverter"),
          centerTitle: true,
          actions: [
            Icon(Icons.calculate_rounded),
          ],
          bottom: const TabBar(tabs: tabs),
        ),
        body: TabBarView(children: views),
      ),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Length'),
  Tab(text: 'Area'),
  Tab(text: 'Volume')
];

const List<Widget> views = [
  Converter(),
  AreaConverter(),
  VolumeConverter()
];


class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {

  void initState(){
    userInput = 0;
    super.initState();
  }

  //for dropdown button list
  final List<String> measures = [
    'Meter',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles'
    'Pounds (lbs)',
    'ounces'
  ];

  final Map<String,int> measuresMap = {
    'Meter':0,
    'Kilometer':1,
    'Grams':2,
    'Kilograms (kg)':3,
    'Feet':4,
    'Pounds (lbs)':5,
    'Miles':6,
    'ounces':7
  };

  dynamic formulas ={

    '0':[1,0.001,0,0,3.280,0.0006213,0],
    '1':[1000,1,0,0,3280.84,0,6213,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220,0.03],
    '3':[0,0,1000,1,0,0,2.2046,35.274],
    '4':[0.0348,0.00030,0,0,1,0.000189],
    '5':[1609.34,1.60934,0,05280,1,0,0],
    '6':[0,0,453.592,0.4535,0,0,1,16],
    '7':[0,0,28.3495,0.02834,3.28084,0,0.1]
  };

  void convert(double value, String from, String to){
    int nFrom = measuresMap[from]!;
    int nTo = measuresMap[to]!;

    var multi = formulas[nFrom.toString()][nTo];
    var result = value * multi;

    if(result == 0)
      resultMessage = 'cannot performed This conversion';
    else{
      resultMessage = '${userInput.toString()} ${_startMeasures} are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage = resultMessage;
    });

  }

  late double userInput;

  String _startMeasures = 'Meter';
  String _convertMeasures = 'Meter';

  String resultMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //  title: Text("UniConverter"),
      //  centerTitle: true,
      //  backgroundColor: Colors.orange,
      //  actions: [
      //  Icon(Icons.calculate_rounded)
      //  ],
      // ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Unit Converter!",style: TextStyle(
                  color: Colors.black, fontSize: 25,fontWeight: FontWeight.w600
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    onChanged: (text){
                      var input = double.tryParse(text);
                      if(input != null)
                        setState(() {
                          userInput = input;
                        });
                    },

                    style: TextStyle(
                      fontSize: 22,color: Colors.black
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'Enter Your Value',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('From',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _startMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.amber),
                        hint: Text('Choose a unit',style: TextStyle(color: Colors.black,fontSize: 20),),

                        items: measures.map((String value){
                        return DropdownMenuItem(value: value,
                        child: Text(value),);
                      }).toList(),
                      onChanged: (value){
                          setState(() {
                            _startMeasures = value!;
                          });
                      },),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text('To',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _convertMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.amber),
                        hint: Text('Choose a unit',style: TextStyle(color: Colors.black,fontSize: 20),),

                        items: measures.map((String value){
                          return DropdownMenuItem(value: value,
                            child: Text(value),);
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            _convertMeasures = value!;
                          });
                        },),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                OutlinedButton(
                  onPressed: (){

                    if(_startMeasures.isEmpty || _convertMeasures.isEmpty || userInput == 0)
                      return;
                    else
                      convert(userInput,_startMeasures,_convertMeasures);
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Convert',style: TextStyle(
                      fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black
                    ),),
                  ),
                ),
                SizedBox(height: 15,),
                Text((resultMessage == null) ? '':resultMessage
                  ,style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w700
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AreaConverter extends StatefulWidget {
  const AreaConverter({Key? key}) : super(key: key);

  @override
  State<AreaConverter> createState() => _AreaConverterState();
}

class _AreaConverterState extends State<AreaConverter> {
  void initState(){
    userInput = 0;
    super.initState();
  }

  //for dropdown button list
  final List<String> measures = [
    'Sqr Meter',
    'Sqr Kilometer',
    'Sqr Foot',
    'Sqr yard',
    'Acre',
    'Sqr Mile'
  ];

  final Map<String,int> measuresMap = {
    'Sqr Meter':0,
    'Sqr Kilometer':1,
    'Sqr Foot':2,
    'Sqr yard':3,
    'Acre':4,
    'Sqr Mile':5
  };

  dynamic formulas ={

    '0':[1,0.000001000000,10.764,1.19599,0.000247105,3.8610215854781257],
    '1':[1000000,1,10763910.42,1195990.046301,247.1,0.386102],
    '2':[0.092903,9.290303997,1,0.111111,0.000023,3.587006427],
    '3':[0.836127,8.3613,9,1,0.000206612,3.2283],
    '4':[4046.86,0.00404686,43560,4840,1,0.0015625],
    '5':[2.59e+6,2.58999,2.788e+7,3.098e+6,640,1]
  };

  void convert(double value, String from, String to){
    int nFrom = measuresMap[from]!;
    int nTo = measuresMap[to]!;

    var multi = formulas[nFrom.toString()][nTo];
    var result = value * multi;

    if(result == 0)
      resultMessage = 'cannot performed This conversion';
    else{
      resultMessage = '${userInput.toString()} ${_startMeasures} are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage = resultMessage;
    });

  }

  late double userInput;

  String _startMeasures = 'Sqr Meter';
  String _convertMeasures = 'Sqr Meter';

  String resultMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("UniConverter"),
      //   centerTitle: true,
      //   backgroundColor: Colors.orange,
      //   actions: [
      //     Icon(Icons.calculate_rounded)
      //   ],
      // ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Unit Converter!",style: TextStyle(
                    color: Colors.black, fontSize: 25,fontWeight: FontWeight.w600
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    onChanged: (text){
                      var input = double.tryParse(text);
                      if(input != null)
                        setState(() {
                          userInput = input;
                        });
                    },

                    style: TextStyle(
                        fontSize: 22,color: Colors.black
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Enter Your Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('From',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _startMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.amber),
                        hint: Text('Choose a unit',style: TextStyle(color: Colors.black,fontSize: 20),),

                        items: measures.map((String value){
                          return DropdownMenuItem(value: value,
                            child: Text(value),);
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            _startMeasures = value!;
                          });
                        },),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text('To',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButton(
                      value: _convertMeasures,
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.amber),
                      hint: Text('Choose a unit',style: TextStyle(color: Colors.black,fontSize: 20),),

                      items: measures.map((String value){
                        return DropdownMenuItem(value: value,
                          child: Text(value),);
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          _convertMeasures = value!;
                        });
                      },),
                  ),
                ),
                SizedBox(height: 10,),
                OutlinedButton(
                  onPressed: (){

                    if(_startMeasures.isEmpty || _convertMeasures.isEmpty || userInput == 0)
                      return;
                    else
                      convert(userInput,_startMeasures,_convertMeasures);
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Convert',style: TextStyle(
                        fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black
                    ),),
                  ),
                ),
                SizedBox(height: 15,),
                Text((resultMessage == null) ? '':resultMessage
                  ,style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.w700
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VolumeConverter extends StatefulWidget {
  const VolumeConverter({Key? key}) : super(key: key);

  @override
  State<VolumeConverter> createState() => _VolumeConverterState();
}

class _VolumeConverterState extends State<VolumeConverter> {
  void initState(){
    userInput = 0;
    super.initState();
  }

  //for dropdown button list
  final List<String> measures = [
    'Litre',
    'Mililitre',
    'Cubic Meter',
    'Cubic Foot',
    'Cubic Inch'

  ];

  final Map<String,int> measuresMap = {
    'Litre':0,
    'Mililitre':1,
    'Cubic Meter':2,
    'Cubic Foot':3,
    'Cubic Inch':4
  };

  dynamic formulas ={

    '0':[1,1000,0.001,0.0353147,61.0237],
    '1':[0.001,1,1e-6,3.5315e-5,0.0610237],
    '2':[1000,1000000,1,35.3147,61023.7],
    '3':[28.3168,28316.8,0.0283168,1,1728],
    '4':[0.0163871,16.3871,1.6387e-5,0.000578704,1]

  };

  void convert(double value, String from, String to){
    int nFrom = measuresMap[from]!;
    int nTo = measuresMap[to]!;

    var multi = formulas[nFrom.toString()][nTo];
    var result = value * multi;

    if(result == 0)
      resultMessage = 'cannot performed This conversion';
    else{
      resultMessage = '${userInput.toString()} ${_startMeasures} are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage = resultMessage;
    });

  }

  late double userInput;

  String _startMeasures = 'Litre';
  String _convertMeasures = 'Litre';

  String resultMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("UniConverter"),
      //   centerTitle: true,
      //   backgroundColor: Colors.orange,
      //   actions: [
      //     Icon(Icons.calculate_rounded)
      //   ],
      // ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Unit Converter!",style: TextStyle(
                    color: Colors.black, fontSize: 25,fontWeight: FontWeight.w600
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    onChanged: (text){
                      var input = double.tryParse(text);
                      if(input != null)
                        setState(() {
                          userInput = input;
                        });
                    },

                    style: TextStyle(
                        fontSize: 22,color: Colors.black
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Enter Your Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('From',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _startMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.amber),
                        hint: Text('Choose a unit',style: TextStyle(color: Colors.black,fontSize: 20),),

                        items: measures.map((String value){
                          return DropdownMenuItem(value: value,
                            child: Text(value),);
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            _startMeasures = value!;
                          });
                        },),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text('To',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _convertMeasures,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.amber),
                        hint: Text('Choose a unit',style: TextStyle(color: Colors.black,fontSize: 20),),

                        items: measures.map((String value){
                          return DropdownMenuItem(value: value,
                            child: Text(value),);
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            _convertMeasures = value!;
                          });
                        },),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                OutlinedButton(
                  onPressed: (){

                    if(_startMeasures.isEmpty || _convertMeasures.isEmpty || userInput == 0)
                      return;
                    else
                      convert(userInput,_startMeasures,_convertMeasures);
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Convert',style: TextStyle(
                        fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black
                    ),),
                  ),
                ),
                SizedBox(height: 15,),
                Text((resultMessage == null) ? '':resultMessage
                  ,style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.w700
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
