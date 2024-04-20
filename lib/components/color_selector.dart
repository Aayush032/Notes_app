import "package:flutter/material.dart";
import "package:notes_app/theme/bg_provider.dart";
import "package:provider/provider.dart";

class CustomColorSelector extends StatefulWidget {
  const CustomColorSelector({super.key});

  @override
  State<CustomColorSelector> createState() => _CustomColorSelectorState();
}

class _CustomColorSelectorState extends State<CustomColorSelector> {
  int currentIndex = 0;
  final List<Color> colorList = [
    Colors.blueAccent,
    Colors.redAccent,
    const Color.fromARGB(255, 29, 114, 73),
    Colors.pinkAccent,
    Colors.blueGrey,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: colorList.length,
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                currentIndex = index;
                Provider.of<BackgroundProvider>(context,listen: false).changeColor(colorList[currentIndex]);
                setState(() {});
              },
              child: ColorTile(
                isActive: currentIndex == index,
                bgColor: colorList[index],
              ),
            );
          }),
    );
  }
}

class ColorTile extends StatelessWidget {
  const ColorTile({
    super.key,
    //required this.colorList,
    required this.isActive,
    required this.bgColor,
  });

  // final List<Color> colorList;
  final bool isActive;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: isActive
              ? Border.all(color: Theme.of(context).colorScheme.inversePrimary, width: 3)
              : Border.all(color: Theme.of(context).colorScheme.background),
              ),
    );
  }
}
