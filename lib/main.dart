import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Date Picker",
      home: HomePage(),
    );
  }
}
 
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}
 
class _HomePage extends State<HomePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeinput = TextEditingController(); 
 
  @override
  void initState() {
    dateController.text = ""; 
    timeinput.text = "";
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Date Time Picker"),
          backgroundColor: Colors.redAccent, 
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.width / 2,
            child: Center(
                child: Column(
                  children: [
                    TextField(
              controller: dateController,
              //editing controller of this TextField
              decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
              readOnly: true,
              
              onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        
                        lastDate: DateTime(2100));
 
               if(pickedDate != null ){
                          print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          print(formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                          setState(() {
                             dateController.text = formattedDate; //set foratted date to TextField value. 
                          });
                      }else{
                          print("Date is not selected");
                      } 
              },
            ),
            TextField(
              controller: timeinput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_clock), //icon of text field
                  labelText: "Enter Time" //label text of field
                  ),
              readOnly: true,
              
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    
                );
                if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        timeinput.text = formattedTime; //set the value of text field. 
                      });
                  }else{
                      print("Time is not selected");
                  }
              },
            )
                  ],
                ))));
  }
}