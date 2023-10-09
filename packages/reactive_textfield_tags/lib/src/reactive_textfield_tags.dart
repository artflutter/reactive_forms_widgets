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
    EdgeInsets chipMargin = const EdgeInsets.only(right: 4.0),
    //////////////////////////////////////////////////////////////////////////
    // put component specific params here
    bool? autoFocus,
    int minLines = 1,
    BoxDecoration? widgetDecoration,
    InputBorder? inputBorder,
    BorderSide? chipBorder,
    bool createTagsOnReturn = false,
    bool createTagsOnBlur = false,
    EdgeInsets widgetPadding =
        const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
  }) : super(
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
                  /// decide max lines
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

                  /// Update reactive form value
                  field.didChange(tags);

                  return Container(
                    decoration: widgetDecoration,
                    padding: widgetPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        tags.isNotEmpty
                            ? Wrap(
                                children: tags.map((String tag) {
                                return Container(
                                  margin: chipMargin,
                                  child: Chip(
                                    label: Text(
                                      tag,
                                      style: tagTextStyle,
                                    ),
                                    backgroundColor: chipColor,
                                    clipBehavior: Clip.antiAlias,
                                    side: chipBorder,
                                    deleteIcon: deleteIcon,
                                    onDeleted: () {
                                      onTagDelete(tag);
                                    },
                                  ),
                                );
                              }).toList())
                            : Container(),
                        TextField(
                          controller: tec,
                          focusNode: fn,
                          autofocus: autoFocus ?? false,
                          onChanged: onChanged,
                          onSubmitted: onSubmitted,
                          decoration: InputDecoration(
                            errorText: error,
                            border: inputBorder,
                          ),
                          minLines: minLines,
                          maxLines: maxLines,
                        ),
                      ],
                    ),
                  );
                });
              },
            );
          },
        );
}
