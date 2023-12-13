import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final _controller = OverlayPortalController();
  final _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Offset widgetOffset = const Offset(0, 0);

    void findWidgetPosition() {
      RenderBox renderBox =
          _widgetKey.currentContext?.findRenderObject() as RenderBox;

      // Obter a posição global do widget
      Offset widgetPosition = renderBox.localToGlobal(Offset.zero);

      widgetOffset = Offset(
        widgetPosition.dx,
        widgetPosition.dy + renderBox.size.height + 5,
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  key: _widgetKey,
                  onPressed: () {
                    findWidgetPosition();

                    _controller.toggle();
                  },
                  child: OverlayPortal(
                    controller: _controller,
                    overlayChildBuilder: (context) {
                      return PopoverWidget(
                        direction: PopoverDirection.topCenter,
                        positionY: widgetOffset.dy,
                        positionX: widgetOffset.dx,
                      );
                    },
                    child: const Text('Press Me'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PopoverDirection {
  topCenter,
  topLeft,
  topRight,
  bottomCenter,
  bottomLeft,
  bottomRight,
}

class PopoverWidget extends StatelessWidget {
  const PopoverWidget({
    super.key,
    required this.direction,
    required this.positionY,
    required this.positionX,
  });

  final PopoverDirection direction;
  final double positionY;
  final double positionX;

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case PopoverDirection.topCenter:
        return Positioned(
          bottom: positionY,
          left: positionX - 54,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      case PopoverDirection.topLeft:
        return Positioned(
          bottom: positionY,
          right: positionX,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      case PopoverDirection.topRight:
        return Positioned(
          bottom: positionY,
          left: positionX,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      case PopoverDirection.bottomCenter:
        return Positioned(
          top: positionY,
          left: positionX - 54,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      case PopoverDirection.bottomLeft:
        return Positioned(
          top: positionY,
          right: positionX,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      case PopoverDirection.bottomRight:
        return Positioned(
          top: positionY,
          left: positionX,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
    }
  }
}
