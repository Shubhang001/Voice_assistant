import 'package:chat_bot/feature_box.dart';
import 'package:chat_bot/pallete.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Allen"),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        //controller: ScrollController(),
        
        child: Column(children: [
          // Virtual Assistant Picture
        
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle),
                ),
              ),
              Container(
                height: 123,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/virtualAssistant.png'))),
              )
            ],
          ),
        
          //Chat bubble
        
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
            decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Good Morning, what task can I do for you?",
                style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 18,
                    fontFamily: 'Cera Pro'),
              ),
            ),
          ),
        
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 10, left: 25),
            child: const Text(
              "Here are a few features",
              style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontFamily: "Cera pro",
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        
          //Features List
        
          const Column(
            children: [
              FeatureBox(
                color: Pallete.firstSuggestionBoxColor,
                headerText: "Chat GPT",
                descriptionText: "A smarter way to stay organized with ChatGPT",
              ),
               FeatureBox(
                color: Pallete.secondSuggestionBoxColor,
                headerText: "Dall-E",
                descriptionText: "Get inspired and stay creative with your personal assistant powered by Dall-E",
              ),
              FeatureBox(
                color: Pallete.secondSuggestionBoxColor,
                headerText: "Smart Voice Asssistant",
                descriptionText: "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
              )
            ],
          )
        ]),
      ),
    );
  }
}
