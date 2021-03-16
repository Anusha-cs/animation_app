import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'My Clock',
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  HomeScreenState();

  _currentTime() {
    return "${DateTime.now().hour} : ${DateTime.now().minute}";
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Clock',
          style: TextStyle(fontSize: 32.0),
        )),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.brown[400],
          border: Border.all(
            color: Colors.orange,
            width: 10,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.brown[400],
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                child: Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.cyan[900],
                      border: Border.all(
                        color: Colors.grey[100],
                        width: 5,
                        style: BorderStyle.solid,
                      ),
                      image: DecorationImage(
                          image: AssetImage("images/round.png"),
                          fit: BoxFit.fill),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange[400],
                          blurRadius: 5,
                          spreadRadius: 15,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _currentTime(),
                        style: TextStyle(
                            fontSize: 60.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image.asset(
                    'images/pandulum.png',
                    width: 100,
                    height: 250,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
