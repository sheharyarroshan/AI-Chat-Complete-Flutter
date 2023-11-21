import 'package:ai_chatty/Model/AdHelper.dart';
import 'package:ai_chatty/Utils/constants.dart';
import 'package:ai_chatty/Utils/indicator.dart';
import 'package:ai_chatty/Utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sitesurface_flutter_openai/sitesurface_flutter_openai.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isLoading = false;

  AdmobHelper admobHelper = new AdmobHelper();
  int count = 0;
  void initState() {
    super.initState();

    admobHelper.createInterad();
  }

  final _openAiClient = OpenAIClient(OpenAIConfig(
      apiKey: "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",
      organizationId: "org-suHjdp1F1mTu7Uq3OxYI7JeX"));

  final _textEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final _completionRequest =
      CreateCompletionRequest(model: "text-davinci-003", maxTokens: 200);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          ThemeData(primaryIconTheme: const IconThemeData(color: Colors.white)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 20,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: purple_clr,
          title: Row(
            children: [
              SvgPicture.asset("assets/icon2.svg"),
              const SizedBox(width: 15),
              Text('Chat Box')
            ],
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: nMbtn,
                      child: const Text(
                        'i',
                        style: TextStyle(
                            fontFamily: "Georgia",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
        body: ChatGPTBuilder(
          completionRequest: _completionRequest,
          openAIClient: _openAiClient,
          builder: (context, messages, onSend) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                      itemCount: messages.length,
                      controller: _scrollController,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                      itemBuilder: (context, index) {
                        var isSender = !messages[index].fromChatGPT;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isSender
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(right: 18.0, bottom: 5),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                        "assets/profile.svg",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, bottom: 5),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SvgPicture.asset(
                                        "assets/icon.svg",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                            GestureDetector(
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(
                                    text: messages[index].message));
                                Fluttertoast.showToast(
                                  msg: "Text copied",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: purple_clr,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                              child: BubbleSpecialThree(
                                isSender: isSender,
                                text: messages[index].message,
                                color: isSender
                                    ? purple_clr
                                    : background_aiChat_clr,
                                tail: true,
                                textStyle: TextStyle(
                                    color: isSender
                                        ? Colors.white
                                        : Colors.grey[800],
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150.0),
                  child: _isLoading ? TypingIndicator() : SizedBox(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, right: 10, left: 10),
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(10, 10),
                                color: Color(0xFFE3E3E3),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                offset: Offset(-10, -10),
                                color: Color(0xFFE3E3E3),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Center(
                            child: TextField(
                              style: const TextStyle(color: purple_clr),
                              cursorColor: purple_clr,
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                                hintText: 'Type a message',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: purple_clr,
                      onPressed: () {
                        count++;
                        if (count == 5) {
                          admobHelper.showInterad();

                          setState(() {
                            count = 0;
                            admobHelper.createInterad();
                          });
                        }

                        if (_textEditingController.text.trim().isEmpty) return;
                        onSend(_textEditingController.text).whenComplete(() {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        }).then((_) => setState(() => _isLoading = false));
                        FocusScope.of(context).unfocus();
                        _textEditingController.clear();
                        setState(() => _isLoading = true);
                      },
                      child: const Icon(Icons.send),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: purple_clr,
      child: const Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        admobHelper.showInterad();
        Navigator.of(context).pop();
      },
    );

    // create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.green,
        size: 25,
      ),
      title: const Text(
        "Our Goal?",
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        "Unlock the full potential of your business with FinAstra AI technologies - where intelligent automation meets unparalleled precision.",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Center(child: okButton),
      ],
      backgroundColor: const Color(0xff2B3047),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
