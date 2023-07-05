import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Test5 extends StatelessWidget {

  const Test5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list2 = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownvalue = 'Apple';
  var items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];
  @override
  Widget build(BuildContext context) {
    String dropdownValue = list2.first;

    return Scaffold(
      appBar: AppBar(
        title: Text("DropDownList Example"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("DropDownButton"),
                ElevatedButton(
                  onPressed: () async{
                  },
                  child: const Text("Click"),
                ),
                Container(
                    height: 40,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        value: dropdownvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                        // buttonHeight: 40,
                        // buttonWidth: 140,
                        // itemHeight: 40,
                      ),
                    )),

                DropdownButton<String>(
                  value:list2.first,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list2.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// class BoardingModel{
//   final String image;
//   final String title;
//   final String body;
//   BoardingModel({
//     required this.body,required this.image,required this.title
//   });
//
// }
// class OnBoardingScreen extends StatefulWidget {
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   var boardController =PageController();
//
//   List<BoardingModel> boarding=[
//
//     BoardingModel(body: 'On board 1 body', image: 'assets/images/quiz.png', title: 'On board 1 title'),
//     BoardingModel(body: 'On board 2 body', image: 'assets/images/quiz.png', title: 'On board 2 title'),
//     BoardingModel(body: 'On board 3 body', image: 'assets/images/quiz.png', title: 'On board 3 title'),
//
//   ] ;
//   bool isLast=false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//             Expanded(child: PageView.builder(
//               onPageChanged: (int index){if(index== boarding.length-1){
//                 setState(() {
//                   isLast=true;
//                 });
//                 print('last');
//
//               }
//               else {
//                 setState(() {
//                   isLast=false;
//                 });
//               }
//
//               },
//               controller: boardController,
//               physics: BouncingScrollPhysics(),
//               itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
//               itemCount: boarding.length,
//             )),
//             SizedBox(
//               height: 40.0,
//             ),
//             Row(
//               children: [
//                 SmoothPageIndicator(controller: boardController,
//                   count: boarding.length,
//                   effect: ExpandingDotsEffect(
//                       dotColor: Colors.grey ,
//                       dotHeight: 10.0,
//                       expansionFactor: 4,
//                       dotWidth: 10,
//                       spacing: 5,
//                       activeDotColor: Colors.cyan
//
//                   ),
//                 ),
//                 Spacer(),
//                 FloatingActionButton(onPressed: (){
//                   boardController.nextPage(duration: Duration(
//                     milliseconds: 750,
//                   ),
//                       curve: Curves.easeInOutCubic);
//                 },
//                   child: Icon(
//                       Icons.arrow_forward_ios
//                   ),),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildBoardingItem(BoardingModel model) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//
//         child: Image(
//             image:AssetImage('${model.image}')
//         ),
//       ),
//       SizedBox(height: 30,),
//       Text(
//         '${model.title}',
//         style: TextStyle(fontSize: 24.0),
//       ),
//       SizedBox(height: 30,),
//       Text(
//         '${model.body }',
//         style: TextStyle(fontSize: 14.0),
//       ),
//       SizedBox(height: 30,),
//
//     ],
//   );
// }
