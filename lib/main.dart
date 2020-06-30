import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import "package:collection/collection.dart";

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
    Map<String, List<Question>> groups = groupBy(questions, (g) => g.category);

    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              height: 50.0,
              color: Colors.blueGrey[700],
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                (groups.keys.toList()[index]).toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: Container(
              child: Column(
                children: <Widget>[
                  for (var question in groups[(groups.keys.toList()[index])])
                    QuestionWidget(question: question),
                ],
              ),
            ),
          );
        });
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key key,
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int _answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.question.questionTxt.trim(),
              style: const TextStyle(fontSize: 22),
            ),
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('01 - '),
                const Text(
                  'Strongly disagree',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
            value: 1,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('02 - '),
                const Text(
                  'Strongly disagree',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
            value: 2,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('03 - '),
                const Text(
                  'Strongly disagree',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
            value: 3,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('04 - '),
                const Text(
                  'Disagree',
                  style: const TextStyle(color: Colors.deepOrange),
                ),
              ],
            ),
            value: 4,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('05 - '),
                const Text(
                  'Disagree',
                  style: const TextStyle(color: Colors.deepOrange),
                ),
              ],
            ),
            value: 5,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('06 - '),
                const Text(
                  'Maybe',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            value: 6,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('07 - '),
                const Text(
                  'Agree',
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            value: 7,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('08 - '),
                const Text(
                  'Strongly agree',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            value: 8,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('09 - '),
                const Text(
                  'Strongly agree',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            value: 9,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
          RadioListTile<int>(
            title: Row(
              children: <Widget>[
                const Text('10 - '),
                const Text(
                  'Strongly agree',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            value: 10,
            groupValue: widget.question.answer,
            onChanged: (int value) {
              setState(() {
                widget.question.setAnswer(value);
              });
            },
          ),
        ],
      ),
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
      var questionTxt = elemets[3];
      questions.add(Question(
        index: index,
        category: category,
        group: group,
        effect: effect,
        questionTxt: questionTxt,
      ));
      notifyListeners();
    }
  }

  void addcontacts(Question question) {
    questions.add(question);
    print(question);
    notifyListeners();
  }
}

// class Question1 with ChangeNotifier {
//   final int index;
//   final String category;
//   final String group;
//   final String effect;
//   final String questionTxt;
//   bool isAnswered;
//   int answer;
//   Question(
//       this.index, this.category, this.group, this.effect, this.questionTxt);

//   void setAnswer(int answer) {
//     this.isAnswered = true;
//     this.answer = answer;
//     notifyListeners();
//   }
// }

class Question with ChangeNotifier {
  int index;
  String category;
  String group;
  String effect;
  String questionTxt;
  bool isAnswered;
  int answer;

  Question(
      {this.index,
      this.category,
      this.group,
      this.effect,
      this.questionTxt,
      this.isAnswered,
      this.answer});

  Question.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    category = json['category'];
    group = json['group'];
    effect = json['effect'];
    questionTxt = json['questionTxt'];
    isAnswered = json['isAnswered'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['category'] = this.category;
    data['group'] = this.group;
    data['effect'] = this.effect;
    data['questionTxt'] = this.questionTxt;
    data['isAnswered'] = this.isAnswered;
    data['answer'] = this.answer;
    return data;
  }

  Future<void> setAnswer(int answer) async {
    this.isAnswered = true;
    this.answer = answer;
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/${this.index}.txt');
    file.writeAsString(jsonEncode(this));
    notifyListeners();
  }
}




