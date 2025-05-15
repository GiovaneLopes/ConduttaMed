import 'package:flutter/material.dart';

enum HomeItemType {
  emphasys,
  protocols,
  converters;

  String get name {
    switch (this) {
      case HomeItemType.emphasys:
        return 'Sestaques';
      case HomeItemType.protocols:
        return 'Protocolos';
      case HomeItemType.converters:
        return 'Calculadoras';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeItemType.emphasys:
        return Icons.list;
      case HomeItemType.protocols:
        return Icons.list;
      case HomeItemType.converters:
        return Icons.change_circle;
    }
  }
}
