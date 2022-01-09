import 'package:flutter/material.dart';

import 'funds_preview.dart';
import '../../classes/funds_list.dart';

class FundsListPage extends StatefulWidget
{
  @override
  _FundsListPageState createState() => new _FundsListPageState();
}

class _FundsListPageState extends State<FundsListPage> with SingleTickerProviderStateMixin
{
  AnimationController animationController;
  Animation<Color> boughtBgColorAnimation;
  Animation<Color> boughtIconColorAnimation;

  bool showBoughtOverlay = false;
  int fund = 0;
  
  @override
  void initState()
  {
    super.initState();
    animationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
    animationController.addListener(() => setState(() {}));

    boughtBgColorAnimation = new ColorTween
    (
      begin: Colors.transparent,
      end: new Color(0xF04CAF50)
    ).animate
    (
      new CurvedAnimation
      (
        parent: animationController,
        curve: Curves.decelerate
      )
    );

    boughtIconColorAnimation = new ColorTween
    (
      begin: Colors.transparent,
      end: Colors.white
    ).animate
    (
      new CurvedAnimation
      (
        parent: animationController,
        curve: Curves.decelerate
      )
    );
  }

  @override
  void dispose()
  {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return new Material
    (
      borderRadius: new BorderRadius.circular(8.0),
      child: new Scaffold
      (
        appBar: new AppBar
        (
          backgroundColor: Colors.white,
          elevation: 1.0,
          leading: new IconButton
          (
            onPressed: () => showAboutDialog(context: context, applicationIcon: new Container(width: 60.0, child: new Image.asset('res/app_icon.png')), applicationLegalese: 'Donate to the National Network of Abortion Funds .'),
            icon: new Icon(Icons.menu, color: Colors.black),
          ),
          title: new Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              new Text('access', style: new TextStyle(color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.w700)),
              new Text('.', style: new TextStyle(color: Colors.green, fontSize: 36.0, fontWeight: FontWeight.w700))
            ],
          ),
          actions: <Widget>
          [
            new Center
            (
              child: new IconButton
              (
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new CartPage())),
                icon: new Stack
                (
                  children: <Widget>
                  [
                    new Align
                    (
                      alignment: Alignment.center,
                      child: new Icon(Icons.shopping_basket, color: Colors.black),
                    ),
                    new Align
                    (
                      alignment: Alignment.bottomRight,
                      child: new CircleAvatar
                      (
                        radius: 6.0,
                        backgroundColor: Colors.green,
                        child: new Text(Cart.cartItems.length.toString(), style: new TextStyle(color: Colors.white, fontSize: 8.0)),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: new Stack
        (
          alignment: Alignment.center,
          children: <Widget>
          [
            /// Funds list, donate button
            new Column
            (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                /// Funds PageView
                new Expanded
                (
                  child: new PageView.builder
                  (
                    scrollDirection: Axis.horizontal,
                    itemCount: fundsList.length,
                    itemBuilder: (_, int pos) => new FundPreview(fundsList[pos]),
                    onPageChanged: (int newFundPos) => fFund = newFundPos,
                  ),
                ),
                /// share buttons
                new Container
                (
                  margin: new EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: new Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>
                    [
                      new Flexible
                      (
                        flex: 1,
                        child: new GestureDetector
                        (
                          onTap: () {},
                          child: new Padding
                          (
                            padding: new EdgeInsets.symmetric(vertical: 16.0),
                            child: new Row
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>
                              [
                                new Icon(Icons.favorite_border, color: Colors.green),
                                new Padding(padding: new EdgeInsets.only(right: 8.0)),
                                new Text('426', style: new TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      new Flexible
                      (
                        flex: 1,
                        child: new GestureDetector
                        (
                          onTap: () {},
                          child: new Padding
                          (
                            padding: new EdgeInsets.symmetric(vertical: 16.0),
                            child: new Row
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>
                              [
                                new Text('Share', style: new TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w700)),
                                new Padding(padding: new EdgeInsets.only(right: 8.0)),
                                new Icon(Icons.share, color: Colors.green),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /// Donate button
                new Hero
                (
                  tag: 'Donate button',
                  child: new MaterialButton
                  (
                    onPressed: () => donate(),
                    color: Colors.green,
                    child: new Padding
                    (
                      padding: const EdgeInsets.all(24.0),
                      child: new Text('Donate to fund', style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
            showBoughtOverlay
            ? new SizedBox.expand
              (
                child: new Container
                (
                  color: boughtBgColorAnimation.value,
                  child: new Center
                  (
                    child: new Icon(Icons.done, size: 128.0, color: boughtIconColorAnimation.value)
                  ),
                ),
              )
            : new Container()
          ],
        ),
      ),
    );
  }

  void donate()
  {
    setState(()
    {
      showBoughtOverlay = true;
      Cart.cartItems.add(fund);

      animationController.forward()
        .then((_) => animationController.reverse()
          .then((_) => setState(() => showBoughtOverlay = false)));
    });
  }
}