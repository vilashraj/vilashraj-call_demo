import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  String phoneNumberDialed;
  Function getCurrentText;
  Keyboard(this.phoneNumberDialed,this.getCurrentText);
  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return keyboard();
  }
  Widget keyboard(){
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:12.0),
                        child: Text(widget.phoneNumberDialed == ""?"Enter number":widget.phoneNumberDialed,style: TextStyle(fontSize: 18,color: widget.phoneNumberDialed == ""?Colors.grey:Colors.black),),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        widget.phoneNumberDialed = widget.phoneNumberDialed.substring(0,widget.phoneNumberDialed.length-1);
                        widget.getCurrentText(widget.phoneNumberDialed);
                      });
                    },
                    onLongPress: (){
                      setState(() {
                        widget.phoneNumberDialed = "";
                        widget.getCurrentText(widget.phoneNumberDialed);

                      });
                    },
                    child: Icon(Icons.backspace),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              keyboardButton(title: "1"),
              keyboardButton(title: "2",subTitle: "A B C"),
              keyboardButton(title: "3",subTitle: "D E F"),
            ],
          ),
          Row(
            children: <Widget>[
              keyboardButton(title: "4",subTitle: "G H I"),
              keyboardButton(title: "5",subTitle: "J K L"),
              keyboardButton(title: "6",subTitle: "M N O"),
            ],
          ),
          Row(
            children: <Widget>[
              keyboardButton(title: "7",subTitle: "P Q R S"),
              keyboardButton(title: "8",subTitle: "T U V"),
              keyboardButton(title: "9",subTitle: "W X Y Z"),
            ],
          ),
          Row(
            children: <Widget>[
              moreButton(),
              keyboardButton(title: "0"),
              callButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget keyboardButton({@required String title,String subTitle = ""}){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: (){
            setState(() {
              widget.phoneNumberDialed = widget.phoneNumberDialed + title;
              widget.getCurrentText(widget.phoneNumberDialed);

            });
          },
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(title,style: TextStyle(color: Colors.white,fontSize: 30),),
                    Text(subTitle,style: TextStyle(color: Colors.white,fontSize: 12),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget moreButton(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            color: Colors.green,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.more_horiz,color: Colors.white,size: 30,)),
                    Column(
                      children: <Widget>[
                        Text("",style: TextStyle(color: Colors.white,fontSize: 34),),
                        Text("",style: TextStyle(color: Colors.white,fontSize: 8),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget callButton(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            color: Colors.green,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.call,color: Colors.white,size: 30,)),
                    Column(
                      children: <Widget>[
                        Text("",style: TextStyle(color: Colors.white,fontSize: 34),),
                        Text("",style: TextStyle(color: Colors.white,fontSize: 8),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}