import 'package:flutter/material.dart';

class CustomColorPage extends StatefulWidget {
  @override
  _CustomColorPageState createState() => _CustomColorPageState();
}

class _CustomColorPageState extends State<CustomColorPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9CC2C3),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF9CC2C3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Image.asset(
                'assets/pill/b13.png',
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(height: 1),
            Container(
              width: 550,
              height: _isExpanded ? 500 : 270,
              decoration: BoxDecoration(
                color: Color(0xFFF4ECEC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metformin Tablets',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '84 pill',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Metformin is an antihyperglycemic agent used to treat type II diabetes along with a healthy diet and exercise.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  if (_isExpanded)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The mechanism of action of the drug metformin\n'
                          'The glycemic regulator metformin belongs to the category of biguanide, and the mechanism of action of metformin is distinct from other classes of antiglycemic drugs:\n'
                          'Metformin reduces blood glucose levels by reducing glucose synthesis from the liver. '
                          'Reduces intestinal absorption of glucose. '
                          'Increases insulin sensitivity by increasing cell absorption of glucose and increasing utilization of it, '
                          'and also inhibits the activity of mitochondrial complex I, and it is this mechanism that gave metformin a strong effect in the treatment of diabetes.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Show less' : 'Show more',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomColorPage(),
  ));
}
