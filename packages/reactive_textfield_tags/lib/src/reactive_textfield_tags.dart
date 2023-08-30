import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveTextfieldTags] that contains a [TextfieldTags].
///
/// This is a convenience widget that wraps a [TextfieldTags] widget in a
/// [ReactiveTextfieldTags].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTextfieldTags
    extends ReactiveFormField<List<String>, List<String>> {
  ///
  ReactiveTextfieldTags(
      {Key? key,
      Key? widgetKey,
      String? formControlName,
      FormControl<List<String>>? formControl,
      Map<String, ValidationMessageFunction>? validationMessages,
      ShowErrorsFunction<List<String>>? showErrors,
      List<String> separators = const [' ', ','],
      Color? chipColor,
      Widget? deleteIcon,
      TextStyle? tagTextStyle
      //////////////////////////////////////////////////////////////////////////
      // put component specific params here
      })
      : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            return TextFieldTags(
              key: widgetKey,
              initialTags: field.value ?? [],
              textSeparators: separators,
              inputfieldBuilder:
                  (context, tec, fn, error, onChanged, onSubmitted) {
                return ((context, sc, tags, onTagDelete) {
                  /// Update reactive form value
                  field.didChange(tags);
                  return TextField(
                    controller: tec,
                    focusNode: fn,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    decoration: InputDecoration(
                      errorText: error,
                      prefixIcon: tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: sc,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: tags.map((String tag) {
                                return Chip(
                                  label: Text(
                                    tag,
                                    style: tagTextStyle,
                                  ),
                                  backgroundColor: chipColor,
                                  deleteIcon: deleteIcon,
                                  onDeleted: () {
                                    onTagDelete(tag);
                                  },
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                  );
                });
              },
            );
          },
        );
}
