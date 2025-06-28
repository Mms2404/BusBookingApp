import 'package:flutter/material.dart';

class AppButtonStyles {

static ButtonStyle topButton = ElevatedButton.styleFrom(
      minimumSize: Size(300, 46),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  

static ButtonStyle bottomButton = ElevatedButton.styleFrom(
      minimumSize: Size(300, 46),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(10),
        ),
      ),
    );

static ButtonStyle commonButton= ElevatedButton.styleFrom(
      minimumSize: Size(300, 46),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
    );


}
