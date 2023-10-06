import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ReactiveTextfieldTags({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<List<String>>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ShowErrorsFunction<List<String>>? showErrors,
    List<String> separators = const [' ', ','],
    Color? chipColor,
    Widget? deleteIcon,
    TextStyle? tagTextStyle,
    //////////////////////////////////////////////////////////////////////////
    // put component specific params here
    bool? autoFocus,
    int minLines = 1,
    InputBorder? border,
    bool createTagsOnReturn = false,
    bool createTagsOnBlur = false,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            return TextFieldTags(
              key: widgetKey,
              focusNode: focusNode,
              initialTags: field.value ?? [],
              textSeparators: separators,
              inputfieldBuilder:
                  (context, tec, fn, error, onChanged, onSubmitted) {
                return ((context, sc, tags, onTagDelete) {
                  /// Update reactive form value
                  final maxLines = minLines + 1;

                  /// create tags on unfocus
                  if (createTagsOnBlur) {
                    fn.addListener(() {
                      if (!fn.hasFocus) {
                        field.didChange(tags);
                        onSubmitted?.call(tec.text);
                      }
                    });
                  }

                  /// create tags on pressing enter
                  if (createTagsOnReturn) {
                    fn.onKeyEvent = (node, event) {
                      if (event.logicalKey == LogicalKeyboardKey.enter) {
                        field.didChange(tags);
                        onSubmitted?.call(tec.text);
                        return KeyEventResult.handled;
                      }
                      return KeyEventResult.ignored;
                    };
                  }
                  field.didChange(tags);
                  return TextField(
                    controller: tec,
                    focusNode: fn,
                    autofocus: autoFocus ?? false,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    decoration: InputDecoration(
                      errorText: error,
                      prefixIcon: tags.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom: (maxLines - 1) * 18.0),
                              child: SingleChildScrollView(
                                controller: sc,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                              ),
                            )
                          : null,
                      border: border,
                    ),
                    minLines: minLines,
                    maxLines: maxLines,
                  );
                });
              },
            );
          },
        );
}
