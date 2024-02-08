import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String kiritishmatni = "Matn kiriting";
  String chiqadimatn = "Translation";
  var dropdownN1 = "uz";
  var dropdownN2 = "en";
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  String xatoText = "Siz xatoga yo'l qo'ydingiz";

  void kiitishmatnialmash(
    String toLang,
  ) {
    translator
        .translate(
      kiritishmatni,
      to: toLang,
    )
        .then((output) {
      setState(() {
        kiritishmatni = output.text;
      });
    });
  }

  void chiqishmatniaylan(
    String toLang,
  ) {
    translator
        .translate(
      chiqadimatn,
      to: toLang,
    )
        .then((output) {
      setState(() {
        chiqadimatn = output.text;
      });
    });
  }

  void translate() {
    translator
        .translate(
      textEditingController.text,
      to: dropdownN2,
    )
        .then((value) {
      chiqadimatn = value.text;
    });
    setState(() {});
  }

  void xatoTextAylan() {
    translator
        .translate(
          xatoText,
          to: dropdownN1,
        )
        .then((value) => xatoText = value.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WordW",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 22, letterSpacing: 5),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 3)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 225, 225, 225),
                  hintText: kiritishmatni,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    letterSpacing: 5,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  letterSpacing: 3,
                ),
                maxLines: 10,
                inputFormatters: [LengthLimitingTextInputFormatter(600)],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: dropDownN1(context),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right_outlined,
                    color: Colors.blue,
                    size: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: dropDownN2(context),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty &&
                            dropdownN1 != dropdownN2) {
                          translate();
                          setState(() {});
                        } else {
                          xatoTextAylan();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                width: double.maxFinite,
                                height: 90,
                                margin: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  bottom: 15,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      xatoText,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 2),
                                    ),
                                    const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                          chiqadimatn = "Translation";
                          chiqishmatniaylan(dropdownN2);
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 2)),
                child: Text(
                  chiqadimatn,
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontSize: 18, letterSpacing: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget dropDownN1(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      iconDisabledColor: Colors.blue,
      iconEnabledColor: Colors.blue,
      value: dropdownN1,
      items: [
        DropdownMenuItem(
          value: "uz",
          child: Text(
            "Uzbek",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "en",
          child: Text(
            "English",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "ru",
          child: Text(
            "Russian",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "tr",
          child: Text(
            "Turkish",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "ko",
          child: Text(
            "Korean",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
      ],
      onChanged: (newvalue) {
        dropdownN1 = newvalue!;
        print(dropdownN1);
        kiitishmatnialmash(dropdownN1);
        setState(() {});
      },
    );
  }

  Widget dropDownN2(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      iconDisabledColor: Colors.blue,
      iconEnabledColor: Colors.blue,
      value: dropdownN2,
      items: [
        DropdownMenuItem(
          value: "uz",
          child: Text(
            "Uzbek",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "en",
          child: Text(
            "English",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "ru",
          child: Text(
            "Russian",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "tr",
          child: Text(
            "Turkish",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "ko",
          child: Text(
            "Korean",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
      ],
      onChanged: (newvalue) {
        dropdownN2 = newvalue!;

        chiqishmatniaylan(dropdownN2);
        setState(() {});
      },
    );
  }
}
