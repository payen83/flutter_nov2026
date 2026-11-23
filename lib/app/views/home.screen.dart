import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController num1controller = TextEditingController();
  final TextEditingController num2controller = TextEditingController();
  int total = 0;

  void calculate(String operator){
    final a = int.tryParse(num1controller.text) ?? 0;
    final b = int.tryParse(num2controller.text) ?? 0;
    setState(() {
      if(operator == '+'){
        total = a + b;
      } else {
        total = a - b;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Calculator', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
              child: TextField(
                keyboardType: TextInputType.number, 
                controller: num1controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter first number'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
              child: TextField(
                keyboardType: TextInputType.number, 
                controller: num2controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter second number'
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Result1: $total', style: TextStyle(fontSize: 20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.red),
                  child: IconButton(onPressed: (){
                    calculate('+');
                  }, icon: Icon(Icons.add, color: Colors.white,)),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.red),
                  child: IconButton(onPressed: (){
                    calculate('-');
                  }, icon: Icon(Icons.remove, color: Colors.white,)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
