import 'package:chat_app/src/constants/colors.dart';
import 'package:flutter/material.dart';

const RED_GRADIENT = RadialGradient(
    center: Alignment.bottomRight, radius: 2, colors: [LIGHT_RED, DARK_RED]);

const BLUE_GRADIENT = LinearGradient(
    colors: [DARK_GREEN, LIGHT_GREEN],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const ORANGE_GRADIENT = LinearGradient(
    colors: [DARK_ORANGE, PALE_ORANGE],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const BRIGHT_ORANGE_GRADIENT =
    LinearGradient(colors: [Color(0xFFD84708), Color(0xFFF77D48)]);
