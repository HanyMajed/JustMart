import 'package:flutter/material.dart';
import 'package:just_mart/features/home/presentation/views/domain/entites/bottom_navigation_bar_entity.dart';
import 'package:just_mart/features/home/presentation/views/widgets/naivtion_bar_item.dart';

class CustomBottomNavigatonbar extends StatefulWidget {
  const CustomBottomNavigatonbar({super.key});

  @override
  State<CustomBottomNavigatonbar> createState() => _CustomBottomNavigatonbarState();
}

class _CustomBottomNavigatonbarState extends State<CustomBottomNavigatonbar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 70,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: bottomNavigationBarItems.asMap().entries.map((e) {
          var index = e.key;
          var entity = e.value;

          return Expanded(
            flex: index == selectedIndex ? 3 : 2,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: NaivationBarItem(
                isSelected: selectedIndex == index,
                bottomNavigationBarEntity: entity,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

//class InActiveItem extends StatelessWidget {
 // const InActiveItem({super.key, required this.image});
 // final String image;
  //@override
  //Widget build(BuildContext context) {
    //return Expanded(
   //   child: SvgPicture.asset(image),
   // );
 // }
//}

//class NaivationBarItem extends StatelessWidget {
 // const NaivationBarItem(
   //   {super.key,
    //  required this.isSelected,
   //   required this.bottomNavigationBarEntity});

  //final bool isSelected;
 // final BottomNavigationBarEntity bottomNavigationBarEntity;
 // @override
 // Widget build(BuildContext context) {
  // return isSelected
      //  ? const ActiveItem()
        //: InActiveItem(
        //    image: bottomNavigationBarEntity.inAactiveImage,
       //   );
 // }
//}

//class ActiveItem extends StatelessWidget {
 // const ActiveItem({super.key});

  //@override
 // Widget build(BuildContext context) {
 //   return const Placeholder();
 // }
//}
