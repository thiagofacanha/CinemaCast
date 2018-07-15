import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/logo.png');
    var image = Image(image: assetsImage, width: 130.0);
    return Container(
      child: image,
      margin: const EdgeInsets.only(bottom: 40.0),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bg = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/bg.png'),
        fit: BoxFit.cover,
      )),
    );
    return bg;
  }
}

class PodCastWidget extends StatelessWidget {
  final Image thumbImage;
  final String title;
  final String description;
  final VoidCallback _onTap;

  PodCastWidget(this.thumbImage, this.title, this.description, this._onTap);

  @override
  Widget build(BuildContext context) {

    var listenNowButton =   Positioned(
      bottom: -15.0,
      left: 0.0,
      right: 0.0,
      child: Align(
        alignment: FractionalOffset.center,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: _onTap,
          child: Text(
            "Ouvir Agora!",
          ),
          color: Colors.amberAccent,
          textColor: Colors.black,
        ),
      ),
    );

    var descriptionContainer = Positioned(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15.0, bottom: 20.0),
          height: 110.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    this.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                    maxLines: 1,
                  ),
                  Text(
                    this.description,
                    style: TextStyle(fontSize: 11.0),
                    maxLines: 4,
                  ),
                ],
              ))
            ],
          ),
        ));

    var logoCinemaCast =   Positioned(
      top: -115.0,
      left: 0.0,
      right: 0.0,
      child: Align(
        alignment: FractionalOffset.center,
        child: Image.asset("assets/logo.png",width: 150.0,height: 150.0,),
      ),
    );

    var podCastThumb = Container(
      height: 270.0,
      width: 270.0,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(image: AssetImage("assets/podcastCover.png"))),
    );
    return GestureDetector(
        child: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        podCastThumb,
        descriptionContainer,
        listenNowButton,
        logoCinemaCast,
      ],
    ));
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  CustomIconButton.small({this.icon, this.iconColor, this.onPressed})
      : size = 30.0;

  CustomIconButton({this.icon, this.iconColor, this.size, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: RawMaterialButton(
          elevation: 0.0,
          child: Icon(
            icon,
            color: iconColor,
          ),
          onPressed: onPressed),
    );
  }
}

class PodCastCarousel extends StatefulWidget {
  List<PodCastWidget> podCastList;

  PodCastCarousel(List<PodCastWidget> list) {
    podCastList = list;
  }

  @override
  _PodCastCarouselState createState() => _PodCastCarouselState();
}

class _PodCastCarouselState extends State<PodCastCarousel> {
  PageController pageController;
  int currentPage = 0;

  @override
  initState() {
    super.initState();
    pageController = new PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.83,
    );
  }

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: new PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            pageSnapping: true,
            reverse: true,
            itemCount: widget.podCastList.length,
            controller: pageController,
            itemBuilder: (context, index) => builder(index)),
      ),
    );
  }

  builder(int index) {
    return Center(
      child: widget.podCastList.elementAt(index),
    );
  }
}
