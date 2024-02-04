// ignore_for_file: unused_element

import 'dart:async';

import 'package:chat_bot/feature_box.dart';
import 'package:chat_bot/openai_service.dart';
import 'package:chat_bot/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  final FlutterTts flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initSpeechtoText();
    initTexttoSpeech();
  }

  //Speech to text Function

  /// This has to happen only once per app
  Future<void> initSpeechtoText() async {
    await speechToText.initialize();
  }

  // Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  // Future<void> stopListening() async {
  //   Timer(Duration(seconds: 15), () async {
  //     print("Stoped recording");
  //     await speechToText.stop();
  //   });

  //   setState(() {});
  // }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  //Speech to Text ends here

  //Text to speech functions

  Future<void> initTexttoSpeech() async {
    await speechToText.initialize();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  //Dispose function is same for both

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

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
                        image:
                            AssetImage('assets/images/virtualAssistant.png'))),
              )
            ],
          ),

          //Chat bubble

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin:
                const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
            decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                generatedContent == null ? "Good Morning, what task can I do for you?": generatedContent!,
                style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: generatedContent == null ? 18 : 15,
                    fontFamily: 'Cera Pro'),
              ),
            ),
          ),

          Visibility(
            visible: generatedContent == null,
            child: Container(
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
          ),

          //Features List

          Visibility(
            visible: generatedContent == null,
            child: const Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: "Chat GPT",
                  descriptionText: "A smarter way to stay organized with ChatGPT",
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: "Dall-E",
                  descriptionText:
                      "Get inspired and stay creative with your personal assistant powered by Dall-E",
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: "Smart Voice Asssistant",
                  descriptionText:
                      "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
                )
              ],
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("pressed");
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          }
          Timer(const Duration(seconds: 6), () async {
            print("lastword = $lastWords");
            final speech = await openAIService.isArtPromptAPI(lastWords);
            if (speech.contains('https')) {
              generatedContent = null;
              generatedImageUrl = speech;
              setState(() {});
            } else {
              generatedContent = speech;
              generatedImageUrl = null;
              await systemSpeak(speech);
              setState(() {});
            }

            print(speech);
          });
          // if (await speechToText.hasPermission &&
          //     speechToText.isListening &&
          //     f % 2 == 0) {
          //   print("Timer stoped");
          //   Timer(const Duration(seconds: 5), () {
          //     stopListening();
          //   });
          // }
          if (await speechToText.hasPermission == false) {
            initSpeechtoText();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
