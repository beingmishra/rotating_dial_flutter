import 'package:flutter/material.dart';
import 'package:rotating_dial/widgets/circle_rotate_widget.dart';
import 'package:rotating_dial/widgets/color_box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    reverseDuration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );

  int selectedIndex = 0;
  bool showColors = false;

  var colors = [
    Colors.black,
    Colors.redAccent,
    Colors.amber,
    Colors.orange,
    Colors.purple,
    Colors.blue,
    Colors.green,
  ];

  List<String> outerRing = [
    'は', 'ぬ', 'ほ', 'も', 'み', 'り', 'い', 'に', 'ひ', 'み', 'り', 'い', 'に', 'ひ',
    'に', 'あ', 'い', 'み', 'ひ', 'も', 'ぬ', 'り', 'み', 'に', 'も', 'い', 'あ', 'り',
    'に', 'も', 'ぬ', 'ひ'
  ];
  List<String> middleRing = [
    'る', 'つ', 'へ', 'し', 'す', 'え', 'け', 'こ', 'ち', 'せ', 'く', 'ち', 'し', 'け',
    'す', 'こ', 'る', 'く', 'し', 'つ', 'す', 'え', 'ち', 'け', 'く', 'こ', 'る', 'す'
  ];
  List<String> innerRing = [
    'ら', 'ね', 'ろ', 'お', 'ま', 'は', 'あ', 'ね', 'ろ', 'ま', 'お', 'ら', 'ね', 'あ',
    'お', 'ま', 'ら', 'は', 'お', 'ろ', 'ら', 'ね', 'あ', 'は', 'ら', 'ね', 'ま', 'ろ'
  ];
  List<String> innermostRing = [
    'ア', 'カ', 'サ', 'タ', 'ナ', 'ハ', 'マ', 'ヤ', 'ラ', 'ワ', 'イ', 'キ', 'シ', 'チ',
    'ニ', 'ヒ', 'ミ', 'リ', 'ウ', 'ク', 'ス', 'ツ', 'ヌ', 'フ', 'ム', 'ユ', 'ル', 'エ',
    'ケ'
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        showColors = !showColors;
                      });
                    },
                    child: Icon(showColors ? Icons.check : Icons.edit, color: Colors.black,),
                  ),
                ],
              ),
            ),
            ScaleTransition(
              scale: _animation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleRotateWidget(speed: 4, words: innermostRing, size: size.width - 180, textColor: colors[selectedIndex].withOpacity(0.2),),
                  CircleRotateWidget(speed: 6, words: innerRing, size: size.width - 120, textColor: colors[selectedIndex].withOpacity(0.4),),
                  CircleRotateWidget(speed: 4, words: middleRing, size: size.width - 60, textColor: colors[selectedIndex].withOpacity(0.75),),
                  CircleRotateWidget(speed: 10, words: outerRing, size: size.width, textColor: colors[selectedIndex],),
                ],
              ),
            ),
            AnimatedOpacity(opacity: showColors ? 1 : 0, duration: const Duration(milliseconds: 300),
            child: Container(
              height: 48,
              margin: const EdgeInsets.only(bottom: 24),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                return ColorBox(isSelected: selectedIndex == index, color: colors[index], onSelect: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },);
              }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 16,);
              },),
            )),
          ],
        ),
      ),
    );
  }
}
