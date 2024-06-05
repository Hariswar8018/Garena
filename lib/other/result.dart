import 'package:flutter/material.dart';

class Mumm extends StatelessWidget {
  const Mumm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height : MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/Screenshot_2024-01-20-14-04-58-25_8ee8015dd2b473d44c46c2d8d6942cec.jpg")
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Result",
              style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: true,
        ),
        body : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height : 40, width : MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color : Color(0xFF053149),
                  borderRadius: BorderRadius.circular(15)
                ),
                
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children : [
                    SizedBox(width : 18),
                    Text("GAMER NAME", style : TextStyle(color : Colors.white)),
                    Spacer(),
                    Text("RANK", style : TextStyle(color : Colors.white)),
                    SizedBox(width : 10),
                    Text("KILL'S", style : TextStyle(color : Colors.white)),
                    SizedBox(width : 10),
                    Text("WON", style : TextStyle(color : Colors.white)),
                    SizedBox(width : 10),
                  ]
                )
              ),
            )
          ]
        )
      ),
    );
  }
}
