import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // Заливка поля
  fillColor: Colors.white,
  filled: true,
  // Делаем границу поля
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  // Рамка поля будет разовой, когда на него тыкнут
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)
  ),
);