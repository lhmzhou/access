import 'package:flutter/material.dart';
import '../../classes/fund.dart';
import '../fullscreen_image_page.dart';

class FundPreview extends StatelessWidget
{
  final Fund fund;
  FundPreview(this.fund);

  final LinearGradient backgroundGradient = new LinearGradient
  (
    colors:
    [
      new Color(0x10000000), // Light black
      new Color(0x30000000), // Dark black
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );

  @override
  Widget build(BuildContext context)
  {
    return new Padding
    (
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0, bottom: 0.0),
      child: new GestureDetector
      (
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new FullscreenImagePage('res/' + fund.fundImg))),
        child: new Material
        (
          borderRadius: new BorderRadius.circular(14.0),
          color: Colors.transparent,
          child: new Stack
          (
            children: <Widget>
            [
              new SizedBox.expand
              (
                child: new Container
                (
                  decoration: new BoxDecoration
                  (
                    gradient: backgroundGradient
                  ),
                ),
              ),
              new Align
              (
                alignment: Alignment.center,
                child: new Hero
                (
                  tag: 'res/' + fund.fundImg,
                  child: new Image.asset('res/${fund.fundImg}')
                )
              ),
              new Align
              (
                alignment: Alignment.bottomLeft,
                child: new Material
                (
                  borderRadius: new BorderRadius.only(topRight: new Radius.circular(14.0)),
                  color: Colors.black,
                  child: new Container
                  (
                    margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: new Text(fund.fundName, style: new TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w700)),
                  ),
                )
              ),
              new Align
              (
                alignment: Alignment.topRight,
                child: new Material
                (
                  borderRadius: new BorderRadius.only(bottomLeft: new Radius.circular(14.0)),
                  color: Colors.green,
                  child: new Container
                  (
                    margin: new EdgeInsets.all(12.0),
                    child: new Text
                    (
                      fund.price - fund.price.truncate() > 0
                       ? '\$${fund.price.toStringAsFixed(2)}'
                       : '\$${fund.price.truncate()}',
                      style: new TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w500)
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}