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
  ReactiveTextfieldTags({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<List<String>>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ShowErrorsFunction<List<String>>? showErrors,
    List<String> separators = const [' ', ','],
    //////////////////////////////////////////////////////////////////////////
    // put component specific params here
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
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  margin: const EdgeInsets.only(right: 10.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Text(tag,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyMedium),
                                        onTap: () {
                                          //print("$tag selected");
                                        },
                                      ),
                                      const SizedBox(width: 4.0),
                                      InkWell(
                                        child: Icon(
                                          Icons.cancel,
                                          size: 14.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                        onTap: () {
                                          onTagDelete(tag);
                                        },
                                      )
                                    ],
                                  ),
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
