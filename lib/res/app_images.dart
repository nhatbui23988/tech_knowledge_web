

import 'package:flutter/material.dart';

const String _assetPath = 'assets';
const String _imagePath = '$_assetPath/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages{
  static const icResearchPath = _Image('ic_research.png');
  static const imgHomeBg = _Image('img_home_background.jpg');
}