
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final Locale currentLocale;

  const LocaleState({required this.currentLocale});

  @override
  List<Object?> get props => [currentLocale];
}
