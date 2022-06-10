import 'package:flutter/material.dart';

import '../ScreenUtils/app_colors.dart';

class MainVehiCard extends StatelessWidget {
  const MainVehiCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PhysicalModel(
      color: Colors.transparent,
      shadowColor: Colors.blue.shade500,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.kgreyDark,
        ),
        width: size.width * 0.9,
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Maint by date:',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Maint by Km:',
                    style: TextStyle(color: Colors.white),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: AppColors.kgreyLightColor,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Led 123',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Image.asset(
                "assets/car.png",
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
