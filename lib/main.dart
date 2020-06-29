import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionsViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: home1(),
    );
  }
}

class home1 extends StatefulWidget {
  home1({Key key}) : super(key: key);

  @override
  _home1State createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App',
      home: new Scaffold(
        appBar: new AppBar(title: new Text('App')),
        body: MyHomePage(),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return new MaterialApp(
  //     title: 'App',
  //     home: new Scaffold(
  //       appBar: new AppBar(title: new Text('App')),
  //       body: Column(
  //         children: <Widget>[
  //           Expanded(flex: 6, child: MyHomePage()),
  //           // Expanded(child: MyHomePage3()),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    var questions = context.watch<QuestionsViewModel>().questions;
    // List<Question> questions = prov.questions;
    if (questions.length == 0) return Text("");

    return Stepper(
      physics: ClampingScrollPhysics(),
      type: StepperType.vertical,
      currentStep: _currentStep,
      onStepTapped: (int step) => setState(() => _currentStep = step),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
          children: <Widget>[
            FlatButton(child: Text("Next"), onPressed: onStepContinue),
          ],
        );
      },
      onStepContinue:
          _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
      onStepCancel:
          _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
      steps: <Step>[
        for (var question in questions)
          Step(
            title: LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 100,
              child: new Text(
                question.index.toString() + question.questionTxt,
              ),
            ),
            content: Slider(
              value: 1,
              onChanged: (v) => {},
              divisions: 10,
              min: 1,
              max: 10,
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
      ],
    );
  }
}

class MyHomePage3 extends StatefulWidget {
  MyHomePage3({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePage3State createState() => _MyHomePage3State();
}

class _MyHomePage3State extends State<MyHomePage3> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return new Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      // onStepTapped: (int step) => setState(() => _currentStep = step),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container();
      },
      steps: <Step>[
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 4 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: Container(),
          content: Container(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
        ),
      ],
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return new Stepper(
      type: StepperType.vertical,
      currentStep: _currentStep,
      onStepTapped: (int step) => setState(() => _currentStep = step),
      onStepContinue:
          _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
      onStepCancel:
          _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
      steps: <Step>[
        new Step(
          title: new Text('Shipping'),
          content: new Text('This is the first step.'),
          isActive: _currentStep >= 0,
          state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: new Text('Payment'),
          content: new Text('This is the second step.'),
          isActive: _currentStep >= 0,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        new Step(
          title: new Text('Order'),
          content: new Text('This is the third step.'),
          isActive: _currentStep >= 0,
          state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        ),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage2(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School1'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// /// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// class Counter with ChangeNotifier, DiagnosticableTreeMixin {
//   int _count = 0;
//   int get count => _count;

//   void increment() {
//     _count++;
//     notifyListeners();
//   }

//   /// Makes `Counter` readable inside the devtools by listing all of its properties
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(IntProperty('count', count));
//   }
// }

Future<List<String>> getdbLines() async {
  return (await loadAssetdb()).split("\n").skip(1).toList();
}

Future<String> loadAssetdb() async {
  return await rootBundle.loadString('assets/db.txt');
}

class QuestionsViewModel with ChangeNotifier {
  final questions = <Question>[];
  QuestionsViewModel() {
    refresh();
    // getdbLines().then(
    //   (dbLines) {
    //     for (var index = 0; index < dbLines.length; index++) {
    //       var dbLine = dbLines[index];
    //       var elemets = dbLine.split("|");
    //       var category = elemets[0];
    //       var group = elemets[1];
    //       var effect = elemets[2];
    //       var questionText = elemets[3];
    //       questions.add(Question(index, category, group, effect, questionText));
    //     }
    //     notifyListeners();

    //     // dbLines.asMap().forEach(
    //     //   (index, dbLine) {
    //     //     var elemets = dbLine.split("|");
    //     //     var category = elemets[0];
    //     //     var group = elemets[1];
    //     //     var effect = elemets[2];
    //     //     var questionText = elemets[3];
    //     //     var answer = "";
    //     //     questions
    //     //         .add(Question(index, category, group, effect, questionText));
    //     //     // _addcontacts(Question(index, category, group, effect, questionText));
    //     //   },
    //     // );
    //   },
    // );
  }

  refresh() async {
    var dbLines = await getdbLines();
    for (var index = 0; index < dbLines.length; index++) {
      var dbLine = dbLines[index];
      var elemets = dbLine.split("|");
      var category = elemets[0];
      var group = elemets[1];
      var effect = elemets[2];
      var questionText = elemets[3];
      questions.add(Question(index, category, group, effect, questionText));
      notifyListeners();
    }
  }

  void addcontacts(Question question) {
    questions.add(question);
    print(question);
    notifyListeners();
  }
}

class Question with ChangeNotifier {
  final int index;
  final String category;
  final String group;
  final String effect;
  final String questionTxt;
  bool isAnswered;
  int answer;
  Question(
      this.index, this.category, this.group, this.effect, this.questionTxt);

  void setAnswer(int answer) {
    this.isAnswered = true;
    this.answer = answer;
    notifyListeners();
  }
}
