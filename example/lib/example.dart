import 'package:chat_shape/chat_shape.dart';
import 'package:flutter/material.dart';

class ChatExamples extends StatelessWidget {
  const ChatExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          //width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// Shape 1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomPaint(
                  painter: ChatShape(
                    context: context,
                    width: 260,
                    height: 50,
                    radius: 30,
                    enableHandleCap: true,
                    color: Colors.deepPurple.shade200,
                    handle: HandleType.straight,
                  ),
                ),
              ),

              /// Shape 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomPaint(
                  painter: ChatShape(
                    context: context,
                    width: 260,
                    height: 50,
                    radius: 30,
                    enableHandleCap: false,
                    color: Colors.deepPurple.shade200,
                    handle: HandleType.straight,
                  ),
                ),
              ),

              /// Shape 3
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomPaint(
                  painter: ChatShape(
                    context: context,
                    width: 260,
                    height: 50,
                    radius: 30,
                    handleHeight: 30,
                    handleWidth: 20,
                    enableHandleCap: true,
                    color: Colors.deepPurple.shade200,
                    handle: HandleType.curved,
                  ),
                ),
              ),

              /// Shape 4
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomPaint(
                  painter: ChatShape(
                    context: context,
                    width: 260,
                    height: 50,
                    radius: 30,
                    enableHandle: false,
                    color: Colors.deepPurple.shade200,
                    handle: HandleType.curved,
                  ),
                ),
              ),

              /// Shape 5
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomPaint(
                  painter: ChatShape(
                    context: context,
                    width: 260,
                    height: 50,
                    radius: 30,
                    handleWidth: 50,
                    handleHeight: 50,
                    applyTopRadius: false,
                    enableHandleCap: false,
                    color: Colors.deepPurple.shade200,
                    handle: HandleType.curved,
                  ),
                ),
              ),

              /// Shape 5
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  //width: 20,
                  child: CustomPaint(
                    //size: const Size(0, 50),
                    painter: ChatShape(
                      context: context,
                      width: 260,
                      height: 90,
                      radius: 20,
                      handleWidth: 200,
                      handleHeight: 80,
                      applyTopRadius: false,
                      enableHandleCap: false,
                      color: Colors.deepPurple.shade200,
                      handle: HandleType.curved,
                    ),
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
