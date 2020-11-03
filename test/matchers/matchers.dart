import 'package:bytebank_app/screens/dashboard/components/feature_item.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String featureItem, IconData icon) =>
    widget is FeatureItem &&
    widget.titleFeature == featureItem &&
    widget.iconData == icon;

bool textFieldByLabelTextMatcher(Widget widget, String labelText) =>
    widget is TextField && widget.decoration.labelText == labelText;
