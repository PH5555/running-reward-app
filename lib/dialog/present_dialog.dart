import 'package:flutter/material.dart';

class PresentDialog extends StatelessWidget {
  const PresentDialog({Key? key}) : super(key: key);

  Widget present(int id) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: Image.asset(
        'imgs/treasure.jpeg',
        width: 45,
      ),
    );
  }

  Widget presentList(int size, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 80,
        decoration: BoxDecoration(
            color: Color(0xff6667AB),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [for (int i = 0; i < size; i++) present(1)],
        ),
      ),
    );
  }

  Widget contentBox(context) {
    return InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            presentList(4, context),
            SizedBox(
              height: 6,
            ),
            Image.asset(
              'imgs/treasure.jpeg',
              width: 80,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '닫으려면 아무곳이나 선택해주세요!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }
}
