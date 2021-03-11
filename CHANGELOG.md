# CHANGELOG

## 0.5.0
- package updates

## 0.4.1
- bugfix: date time picker `touched` handling

## 0.4.0
- updated `touched` handling for date pickers and search box
  now the touched will be applied only on closing popup
  previously the error was shown underneath the popup right after first interation
  which might confuse.
  most of all the searchable dropdown suffered from this behaviour cause the error was
  visible through the semitransparent overlay 

## 0.3.9
- new widget: reactive_date_range_picker

## 0.3.8
- new widget: reactive_image_picker

## 0.3.7
- bugfix: widgets are missing `touched` handling

## 0.3.6
- take disabled property into account

## 0.3.5
- dropdown_search update to v0.4.9

## 0.3.4
- error text missing bugfix

## 0.3.3
- ReactiveDateTimePicker clear -> didChange

## 0.3.2
- ReactiveDateTimePicker validationMessages was missing

## 0.3.1
- ReactiveDateTimePicker bugfix

## 0.3.0
- wrap `dropdown_search` mode

## 0.2.0
- entry point rename

## 0.1.1
- `example` fix

## 0.1.0
- ReactiveDatePickerField => ReactiveDateTimePicker

## 0.0.2
- reactive date picker field

## 0.0.1
- reactive dropdown search
- reactive segmented control
- reactive touch spin
- box decoration border