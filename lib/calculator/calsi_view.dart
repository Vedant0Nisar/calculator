import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/calculator/calsi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorPage extends GetView {
  final CalculatorController controller = Get.put(CalculatorController());

  final List<String> buttons = [
    'AC',
    '±',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '−',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 246, 244, 242),
              Color.fromARGB(255, 249, 228, 214),
              Color.fromARGB(255, 242, 175, 141)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Calculator",
                style: GoogleFonts.majorMonoDisplay(
                  fontSize: 25,
                  color: Colors.orange,
                  fontWeight: FontWeight.w900,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 5.0),
                      blurRadius: 12.0,
                      color: Color.fromARGB(255, 214, 203, 203),
                    ),
                    Shadow(
                      offset: Offset(2.0, 5.0),
                      blurRadius: 12.0,
                      color: Color.fromARGB(123, 162, 162, 174),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Container(
                  height: Get.size.height / 4,
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(width: 10.0, color: Colors.white30),
                  ),
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: SingleChildScrollView(
                          child: Text(
                            controller.displayText.value,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              // Buttons Area
              Expanded(
                flex: 4,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.all(10),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    final button = buttons[index];
                    return ElevatedButton(
                      onPressed: () => controller.appendValue(button),
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: _getButtonColor(button),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        shadowColor: Colors.grey.withOpacity(0.9),
                      ),
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == 'AC') return Colors.red.withOpacity(0.8);
    if (['÷', '×', '−', '+', '='].contains(button))
      return Colors.orange.withOpacity(0.9);
    if (['±', '%', '.'].contains(button)) return Colors.grey.withOpacity(0.7);
    return Colors.grey.shade300;
  }
}
