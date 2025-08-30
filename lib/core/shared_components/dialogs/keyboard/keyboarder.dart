import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/shared_components/bubble/bubble.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

abstract class Keyboarder {
  // -----------------------------------------------------------------------------

  /// NAMES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getText({
    required BuildContext context,
    String headline = 'Name',
    String? initialText,
    KeyboardModel? keyboardModel,
    String? hintVerse,
  }) async {
    String? _output = initialText;

    /// PREVENTS SET STATE DURING BUILD : WEIRD BUT WORKS
    await Future.delayed(const Duration(milliseconds: 200));

    final String? _text = await KeyboardDialog.open(
      context: context,
      screenTitleVerse: headline,
      initialText: initialText,
      keyboardModel: keyboardModel ?? KeyboardModel.standardModel().copyWith(
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.name,
        initialText: initialText,
        titleVerse: headline,
        validator: (String? text) => Formers.personNameValidator(
          name: text,
          canValidate: true,
        ),
        hintVerse: hintVerse,
        autoCorrect: false,
        enableSuggestions: false,
        maxLines: 1,
        minLines: 1,
        maxLength: 5000,
      ),
    );

    if (_TextCheck.isEmpty(_text) == false){
      _output = _text;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PARAGRAPH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getParagraph({
    required BuildContext context,
    String? headline,
    String? initialText,
    KeyboardModel? keyboardModel,
    String? hintVerse,
  }) async {
    String? _output = initialText;

    /// PREVENTS SET STATE DURING BUILD : WEIRD BUT WORKS
    await Future.delayed(const Duration(milliseconds: 200));

    final String? _text = await KeyboardDialog.open(
      context: context,
      screenTitleVerse: headline,
      initialText: initialText,
      keyboardModel: keyboardModel ?? KeyboardModel.standardModel().copyWith(
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.multiline,
        initialText: initialText,
        titleVerse: headline,
        validator: (String? text) => Formers.paragraphValidator(
          text: text,
          canValidate: true,
        ),
        hintVerse: hintVerse,
        autoCorrect: false,
        enableSuggestions: false,
        maxLines: 15,
        minLines: 10,
        maxLength: 5000,
      ),
    );

    if (_TextCheck.isEmpty(_text) == false){
      _output = _text;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}

class KeyboardDialog extends StatefulWidget {
  // --------------------------------------------------------------------------
  const KeyboardDialog({
    required this.keyboardModel,
    this.confirmButtonIsOn = true,
    this.columnChildren,
    this.initialText,
    super.key
  });
  // --------------------------------------------------------------------------
  final KeyboardModel keyboardModel;
  final bool confirmButtonIsOn;
  final List<Widget>? columnChildren;
  final String? initialText;
  // --------------------------------------------------------------------------
  @override
  _KeyboardDialogState createState() => _KeyboardDialogState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> open({
    required BuildContext context,
    KeyboardModel? keyboardModel,
    String? screenTitleVerse,
    String? initialText,
  }) async {

    KeyboardModel _keyboard = keyboardModel ?? KeyboardModel.standardModel();
    _keyboard = _keyboard.copyWith(
      titleVerse: screenTitleVerse,
    );

    final String? _output = await Routing.push(
      context: context,

      screen: KeyboardDialog(
        keyboardModel: _keyboard,
        initialText: initialText,
        // confirmButtonIsOn: true,
      ),
    );

    return _output;
  }
// -----------------------------------------------------------------------------
}

class _KeyboardDialogState extends State<KeyboardDialog> {
  // -----------------------------------------------------------------------------
  final GlobalKey _globalKey = GlobalKey<FormState>();
  late KeyboardModel _keyboardModel;
  final ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);
  final TextEditingController _controller = TextEditingController();
  String _initialText = '';
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _keyboardModel = widget.keyboardModel;
    _initialText = widget.initialText ?? _keyboardModel.initialText ?? '';
    _controller.text = _initialText;

    if (_keyboardModel.focusNode == null){
      _keyboardModel = _keyboardModel.copyWith(
        focusNode: FocusNode(),
      );
    }

    // UiPro.proGetKeyboard().setIsOn(setTo: true);
    // UiPro.proGetKeyboard().keyboardIsOn.addListener(_exitOnKeyboardClosed);

    _onTextChanged(_initialText);

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit == true && mounted == true) {
      _isInit = false; // good

      // _triggerLoading().then((_) async {
      //
      //   /// FUCK
      //
      //   await _triggerLoading();
      // });

      _asyncInSync(() async {

        // blog('should focus');
        await Future.delayed(const Duration(milliseconds: 100), () async {
          Formers.focusOnNode(_keyboardModel.focusNode);
          //   blog('focused aho');
        });

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _canSubmit.dispose();
    _controller.dispose();
    // UiPro.proGetKeyboard().keyboardIsOn.removeListener(_exitOnKeyboardClosed);
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  // bool _keyboardClosingExitHappened = false;
  // Future<void> _exitOnKeyboardClosed() async {
    // if (UiPro.proGetKeyboard().keyboardIsOn.value == false && _keyboardClosingExitHappened == false){
    //   _keyboardClosingExitHappened = true;
    //   await BldrsNav.goBack(
    //     context: context,
    //     passedData: _canPassText == true ? _controller.text : null,
    //   );
    // }
  // }
  // -----------------------------------------------------------------------------

  /// ACTIONS

  // --------------------
  void _onTextChanged(String? text){

    if (_keyboardModel.onChanged != null){
      _keyboardModel.onChanged?.call(text);
    }

    bool _can = true;

    if (_keyboardModel.canBypassValidator == false){

      /// VALIDATOR IS DEFINED
      if (_keyboardModel.validator != null){

        /// VALIDATOR IS VALID
        if (_keyboardModel.validator?.call(_controller.text) == null){

          // if (_initialText == text){
          //   _can = false;
          // }
          // else {
          _can = true;
          // }

        }

        /// VALIDATOR IS NOT VALID
        else {
          _can = false;
        }

      }

      /// VALIDATOR IS NOT DEFINED
      else {
        _can = true;
      }

    }

    _setNotifier(
      notifier: _canSubmit,
      mounted: mounted,
      value: _can,
    );

  }
  // --------------------
  // bool _canPassText = true;
  Future<void> _onSubmit (String? text, bool passText) async {

    // _canPassText = passText;

    // if (_keyboardModel.onSubmitted != null){
    //   if (_keyboardModel.validator == null || _keyboardModel.validator?.call(text) == null){
    //     _keyboardModel.onSubmitted?.call(text);
    //   }
    // }

    // await UiPro.closeKeyboard();

    await Routing.goBack(
      context: context,
      invoker: 'KeyboardScreen',
      passedData: _controller.text,
    );

  }
  // --------------------
  Future<void> _onPaste(String? text) async {
    if (text != null){
      _controller.text = text;
      _onTextChanged(_controller.text);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return _DialogLayout(
      backgroundColor: Colorz.black230,
      swipeDownDismiss: false,
      onBack: () async {
        // await UiPro.closeKeyboard();
        // _onSubmit(_controller.text, false);
        // _keyboardClosingExitHappened = true;
        await Routing.goBack(context: context);
      },
      child: SingleWire<bool>(
        wire: _canSubmit,
        builder: (bool canSubmit){

          // final double _bottomInsets = context.screenInsets.bottom;
          // final bool _center = _bottomInsets == 0;

          return Column(
            // mainAxisAlignment: _center ? MainAxisAlignment.center : MainAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// TEXT FIELD
              Container(
                width: BubbleScale.bubbleWidth(context: context) + 10 ,
                decoration: const BoxDecoration(
                  color: Colorz.black50,
                  borderRadius: BorderRadius.all(Radius.circular(20 + 5)),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),

                child: TextFieldBubble(
                  bubbleWidth: BubbleScale.bubbleWidth(context: context),
                  // _keyboardModel.titleVerse,
                  validator: (String? text){
                    if (_keyboardModel.validator != null){
                      return _keyboardModel.validator?.call(_controller.text);
                    }
                    else {
                      return null;
                    }
                  },
                  onTextChanged: _onTextChanged,
                  onSubmitted: (String? text) => _onSubmit(text, true),
                  formKey: _globalKey,
                  pasteFunction: (String? text) => _onPaste(text),
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineText: _keyboardModel.titleVerse,
                  ),
                  textController: _controller,
                  bubbleColor: Colorz.white80,

                  columnChildren: <Widget>[

                    /// CONFIRM BUTTON
                    if (widget.confirmButtonIsOn == true)
                      Align(
                        alignment: Alignment.centerRight,
                        child: SuperBox(
                          isDisabled: !canSubmit,
                          height: 40,
                          textScaleFactor: 0.6,
                          margins: const EdgeInsets.only(
                            left: TextFieldBubble.pasteButtonWidth + 5,
                            right: TextFieldBubble.pasteButtonWidth + 5,
                            bottom: 5,
                          ),
                          color: Colorz.black255,
                          text: 'Confirm',
                          textItalic: true,
                          onTap: () => _onSubmit(_controller.text, true),
                        ),
                      ),

                    /// EXTRA CHILDREN
                    if (widget.columnChildren != null)
                      ... widget.columnChildren!,

                  ],
                ),
              ),

              /// HORIZON
              const Spacing(size: 20),

            ],
          );

        },
      ),
    );

  }
// -----------------------------------------------------------------------------
}

@immutable
class KeyboardModel {
  // -----------------------------------------------------------------------------
  const KeyboardModel({
    required this.titleVerse,
    required this.autoCorrect,
    required this.enableSuggestions,
    this.initialText,
    this.hintVerse,
    this.minLines = 1,
    this.maxLines = 2,
    this.maxLength,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.isObscured,
    this.counterIsOn = false,
    this.isFormField = false,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    this.isFloatingField = true,
    this.formKey,
    this.validator,
    this.autoValidate = true,
    this.autoFocus = false,

    this.onFieldTap,
    this.pasteFunction,
    this.textDirection,
    this.hintTextDirection,

    this.leadingIcon,
    this.leadingIconSizeFactor = 1,

    this.canBypassValidator = false,
  });
  // --------------------
  final String? titleVerse;
  final String? hintVerse;
  final String? initialText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final ValueNotifier<bool>? isObscured;
  final bool? counterIsOn;
  final bool? isFormField;

  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?>? onSavedForForm;
  final Function? onEditingComplete;
  final bool? isFloatingField;
  final GlobalKey? formKey;
  final String? Function(String? text)? validator;

  final bool autoCorrect;
  final bool enableSuggestions;
  final bool autoValidate;
  final bool autoFocus;

  final Function? onFieldTap;
  final Function(String? text)? pasteFunction;
  final TextDirection? textDirection;
  final TextDirection? hintTextDirection;

  final dynamic leadingIcon;
  final double leadingIconSizeFactor;

  final bool canBypassValidator;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  KeyboardModel copyWith({
    String? titleVerse,
    String? hintVerse,
    String? initialText,
    int? minLines,
    int? maxLines,
    int? maxLength,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    FocusNode? focusNode,
    ValueNotifier<bool>? isObscured,
    bool? counterIsOn,
    bool? isFormField,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSubmitted,
    ValueChanged<String?>? onSavedForForm,
    Function? onEditingComplete,
    bool? isFloatingField,
    GlobalKey? formKey,
    String? Function(String? text)? validator,
    bool? autoCorrect,
    bool? enableSuggestions,
    bool? autoValidate,
    bool? autoFocus,
    Function? onFieldTap,
    Function(String? text)? pasteFunction,
    TextDirection? textDirection,
    TextDirection? hintTextDirection,
    dynamic leadingIcon,
    double? leadingIconSizeFactor,
    bool? canBypassValidator,
  }){
    return KeyboardModel(
      titleVerse: titleVerse ?? this.titleVerse,
      hintVerse: hintVerse ?? this.hintVerse,
      initialText: initialText ?? this.initialText,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
      maxLength: maxLength ?? this.maxLength,
      textInputAction: textInputAction ?? this.textInputAction,
      textInputType: textInputType ?? this.textInputType,
      focusNode: focusNode ?? this.focusNode,
      isObscured: isObscured ?? this.isObscured,
      counterIsOn: counterIsOn ?? this.counterIsOn,
      isFormField: isFormField ?? this.isFormField,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onSavedForForm: onSavedForForm ?? this.onSavedForForm,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      isFloatingField: isFloatingField ?? this.isFloatingField,
      formKey: formKey ?? this.formKey,
      validator: validator ?? this.validator,
      autoCorrect: autoCorrect ?? this.autoCorrect,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      autoValidate: autoValidate ?? this.autoValidate,
      autoFocus: autoFocus ?? this.autoFocus,
      onFieldTap: onFieldTap ?? this.onFieldTap,
      pasteFunction: pasteFunction ?? this.pasteFunction,
      textDirection: textDirection ?? this.textDirection,
      hintTextDirection: hintTextDirection ?? this.hintTextDirection,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      leadingIconSizeFactor: leadingIconSizeFactor ?? this.leadingIconSizeFactor,
      canBypassValidator: canBypassValidator ?? this.canBypassValidator,
    );
  }
  // -----------------------------------------------------------------------------

  /// STANDARD

  // --------------------
  static KeyboardModel standardModel(){
    return const KeyboardModel(
      autoCorrect: false,
      enableSuggestions: false,
      titleVerse: null,
      hintVerse: '...',
      // minLines: 1,
      maxLines: 1,
      // maxLength: null,
      // textInputAction: TextInputAction.done,
      // textInputType: TextInputType.text,
      // focusNode: null,
      // canObscure: false,
      // counterIsOn: false,
      // isFormField: false,
      // onChanged: null,
      // onSubmitted: null,
      // onSavedForForm: null,
      // onEditingComplete: null,
      isFloatingField: false,
      // autoCorrect: checkAutoCorrectShouldBeOn(),
      // enableSuggestions: checkSuggestionsEnabledShouldBeOn(),
      // canBypassValidator: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// TEXT INPUT ACTIONS

  // --------------------
  static List<TextInputAction> textInputActions(){
    return [
      TextInputAction.none,
      TextInputAction.unspecified,
      TextInputAction.done,
      TextInputAction.go,
      TextInputAction.search,
      TextInputAction.send,
      TextInputAction.next,
      TextInputAction.previous,
      TextInputAction.continueAction,
      TextInputAction.join,
      TextInputAction.route,
      TextInputAction.emergencyCall,
      TextInputAction.newline,
    ];
  }
  // -----------------------------------------------------------------------------

  /// TEXT INPUT TYPE

  // --------------------
  static const List<TextInputType> textInputTypes = <TextInputType>[
    TextInputType.text,
    TextInputType.multiline,
    TextInputType.number,
    TextInputType.phone,
    TextInputType.datetime,
    TextInputType.emailAddress,
    TextInputType.url,
    TextInputType.visiblePassword,
    TextInputType.name,
    TextInputType.streetAddress,
    // TextInputType.none,
  ];
  // --------------------
  static List<TextInputType> allTextInputTypes(){
    return const [
      TextInputType.name,
      TextInputType.number,
      TextInputType.text,
      TextInputType.url,
      TextInputType.datetime,
      TextInputType.emailAddress,
      TextInputType.multiline,
      TextInputType.none,
      TextInputType.phone,
      TextInputType.streetAddress,
      TextInputType.visiblePassword,
      TextInputType.numberWithOptions(decimal: true),
      TextInputType.numberWithOptions(signed: true),
      // TextInputType.numberWithOptions(decimal: false),
      // TextInputType.numberWithOptions(signed: false),
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherTextInputType(TextInputType type){
    return _TextMod.removeTextBeforeLastSpecialCharacter(
      text: type.toJson()['name'],
      specialCharacter: '.',
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextInputType? decipherTextInputType(String? type){

    switch(type){
      case 'text'            : return TextInputType.text;
      case 'multiline'       : return TextInputType.multiline;
      case 'number'          : return TextInputType.number;
      case 'phone'           : return TextInputType.phone;
      case 'datetime'        : return TextInputType.datetime;
      case 'emailAddress'    : return TextInputType.emailAddress;
      case 'url'             : return TextInputType.url;
      case 'visiblePassword' : return TextInputType.visiblePassword;
      case 'name'            : return TextInputType.name;
      case 'streetAddress'   : return TextInputType.streetAddress;
      case 'none'            : return TextInputType.none;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// COPY TO CLIPBOARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> copyToClipboardAndNotify({
    required BuildContext context,
    required String? copy,
    int? milliseconds,
  }) async {

    // await TextClipBoard.copy(
    //   copy: copy,
    // );
    //
    // if (milliseconds != 0){
    //   await Dialogs.topNotice(
    //     headlineVerse: const Verse(
    //       id: 'phid_copied_to_clipboard',
    //       translate: true,
    //     ),
    //     bodyVerse: Verse.plain(copy),
    //     milliseconds: milliseconds,
    //   );
    // }

    _blog('copied to clipboard : $copy');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkKeyboardsAreIdentical({
    required KeyboardModel? modelA,
    required KeyboardModel? modelB,
  }){
    bool _areIdentical = false;

    if (modelA == null && modelB == null){
      _areIdentical = true;
    }

    else if (
    modelA != null && modelB != null &&
        modelA.titleVerse == modelB.titleVerse &&
        modelA.hintVerse == modelB.hintVerse &&
        modelA.initialText == modelB.initialText &&
        modelA.minLines == modelB.minLines &&
        modelA.maxLines == modelB.maxLines &&
        modelA.maxLength == modelB.maxLength &&
        modelA.textInputAction == modelB.textInputAction &&
        modelA.textInputType == modelB.textInputType &&
        modelA.focusNode == modelB.focusNode &&
        modelA.isObscured == modelB.isObscured &&
        modelA.counterIsOn == modelB.counterIsOn &&
        modelA.isFormField == modelB.isFormField &&
        modelA.onChanged == modelB.onChanged &&
        modelA.onSubmitted == modelB.onSubmitted &&
        modelA.onSavedForForm == modelB.onSavedForForm &&
        modelA.onEditingComplete == modelB.onEditingComplete &&
        modelA.isFloatingField == modelB.isFloatingField &&
        modelA.formKey == modelB.formKey &&
        modelA.validator == modelB.validator &&
        modelA.autoCorrect == modelB.autoCorrect &&
        modelA.enableSuggestions == modelB.enableSuggestions &&
        modelA.autoValidate == modelB.autoValidate &&
        modelA.autoFocus == modelB.autoFocus &&
        modelA.onFieldTap == modelB.onFieldTap &&
        modelA.pasteFunction == modelB.pasteFunction &&
        modelA.textDirection == modelB.textDirection &&
        modelA.hintTextDirection == modelB.hintTextDirection &&
        modelA.leadingIcon == modelB.leadingIcon &&
        modelA.leadingIconSizeFactor == modelB.leadingIconSizeFactor &&
        modelA.canBypassValidator == modelB.canBypassValidator
    ){
      _areIdentical = true;
    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is KeyboardModel){
      _areIdentical = checkKeyboardsAreIdentical(
        modelA: this,
        modelB: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      initialText.hashCode^
      titleVerse.hashCode^
      hintVerse.hashCode^
      minLines.hashCode^
      maxLines.hashCode^
      maxLength.hashCode^
      textInputAction.hashCode^
      textInputType .hashCode^
      focusNode.hashCode^
      isObscured.hashCode^
      counterIsOn.hashCode^
      isFormField.hashCode^
      onChanged.hashCode^
      onSubmitted.hashCode^
      onSavedForForm.hashCode^
      onEditingComplete.hashCode^
      isFloatingField.hashCode^
      validator.hashCode^
      autoCorrect.hashCode^
      enableSuggestions.hashCode^
      autoValidate.hashCode^
      autoFocus.hashCode^
      onFieldTap.hashCode^
      pasteFunction.hashCode^
      textDirection.hashCode^
      hintTextDirection.hashCode^
      leadingIcon.hashCode^
      leadingIconSizeFactor.hashCode^
      canBypassValidator.hashCode^
      formKey.hashCode;
// -----------------------------------------------------------------------------
}

abstract class Formers {
  // --------------------
  /// TESTED : WORKS PERFECT
  static void focusOnNode(FocusNode? node){

    if (node != null){
      if (node.hasFocus == false){
        node.requestFocus();
      }
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String? emailValidator({
    required String? email,
    required bool? canValidate,
    String? enterEmailWord,
    String? emailInvalidWord,
  }) {
    String? _output;

    if (_Booler.boolIsTrue(canValidate) == true){

      if (_TextCheck.isEmpty(email) == true) {
        _output = enterEmailWord?? 'Enter email';
      }

      else {

        // if (Emailer.validate(email!) == false){
        //   _output = emailInvalidWord ?? 'Email is invalid';
        // }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? personNameValidator({
    required String? name,
    required bool canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (canValidate == true){
      final bool _userNameIsShort = _TextCheck.isShorterThan(
        text: name?.trim(),
        length: 3,
      );
      const bool _containsBadLang = false;

      /// SHORT NAME
      if (_userNameIsShort == true){
        _message =  'Name should be longer than '
            '3 '
            'characters';
      }
      /// BAD LANG
      else if (_containsBadLang == true){
        _message = 'The name can not contain bad words';
      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }
    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? companyNameValidator({
    required String? companyName,
    required bool? canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    if (_Booler.boolIsTrue(canValidate) == true){

      if (_TextCheck.isEmpty(companyName) == true){
        _message = 'Enter business name';
      }

      else {

        final bool _companyNameIsShort = _TextCheck.isShorterThan(
          text: companyName,
          length: 2,
        );
        const bool _containsBadLang = false;

        /// SHORT NAME
        if (_companyNameIsShort == true){

          _message =  'The name should be longer than '
              ' 2 '
              'characters';

        }
        /// BAD LANG
        else if (_containsBadLang == true){
          _message = 'The name can not contain bad words';
        }

      }

      /// FOCUS ON FIELD
      if (_message != null){
        Formers.focusOnNode(focusNode);
      }

    }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? paragraphValidator({
    required String? text,
    required bool canValidate,
    FocusNode? focusNode,
  }){
    String? _message;

    // if (canValidate == true){
    //
    //   /// FOCUS ON FIELD
    //   if (_message != null){
    //     Formers.focusOnNode(focusNode);
    //   }
    //
    // }

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? phoneValidator({
    required String? phone,
    required bool? canValidate,
    required bool isMandatory,
  }){
    String? _message;

    // /// EMPTY
    // if (TextCheck.isEmpty(phone) == true && isMandatory == true){
    //   _message = getWord('phid_phone_number_should_not_be_empty');
    // }
    //
    // if (TextCheck.isEmpty(phone) == false){
    //
    //   /// COUNTRY CODE
    //   if (zoneModel != null){
    //
    //     final String? _code = Flag.getCountryPhoneCode(zoneModel.countryID);
    //     final bool _startsWithCode = TextCheck.stringStartsExactlyWith(
    //       text: phone,
    //       startsWith: _code,
    //     );
    //
    //     if (_startsWithCode == false){
    //       _message ??=  '${getWord('phid_phone_number_in')} '
    //           '${zoneModel.countryName ?? zoneModel.countryID} '
    //           '${getWord('phid_should_start_with')}'
    //           '\n( $_code )';
    //     }
    //
    //   }
    //
    //   /// NUMBER FORMAT
    //   _message ??= numbersOnlyValidator(
    //     text: TextMod.replaceVarTag(
    //       input: phone,
    //       customTag: '+',
    //       customValue: '',
    //     ),
    //   );
    //
    //   _message ??= _maxDigitsExceededValidator(
    //     maxDigits: 0,
    //     text: phone,
    //   );
    //
    // }

    // blog('phoneValidator phone : _message : $_message');

    return _message;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? webSiteValidator({
    required String? website,
    required bool isMandatory,
    List<String>? excludedDomains,
    String? onlyUnderThisDomain,
  }){
    String? _message;

    // /// WEBSITE HAS VALUE
    // if (TextCheck.isEmpty(website) == false){
    //
    //   if (website != 'https://'){
    //
    //     /// IS URL FORMAT
    //     final bool _isURLFormat = ObjectCheck.isURLFormat(website) == true;
    //     if (_isURLFormat == false){
    //       _message = 'The url format is incorrect';
    //     }
    //
    //     /// DOMAIN IS EXCLUDED
    //     if (_message == null){
    //       final bool _domainExcluded = TextCheck.checkStringContainAnyOfSubStrings(
    //         subStrings: excludedDomains,
    //         string: website,
    //       );
    //       if (_domainExcluded == true){
    //         _message = 'Can not use this link here';
    //       }
    //     }
    //
    //     /// ONLY UNDER THIS DOMAIN
    //     if (_message == null && onlyUnderThisDomain != null){
    //       final String? _shouldBe = Linker.extractWebsiteDomain(link: onlyUnderThisDomain);
    //       final String? _is = Linker.extractWebsiteDomain(link: website);
    //       if (_shouldBe != _is){
    //         _message = getWord('phid_can_only_be_under_this_domain');
    //         _message = '$_message $_shouldBe';
    //       }
    //     }
    //
    //   }
    //
    // }
    //
    // /// WEBSITE IS EMPTY
    // else if (isMandatory == true){
    //   _message = getWord('phid_this_field_can_not_be_empty');
    // }

    return _message;
  }
// -----------------------------------------------------------------------------
}

abstract class _TextCheck {
  // --------------------
  // -----------------------------------------------------------------------------
  /// AI TESTED
  static bool isShorterThan({
    required String? text,
    required int? length,
  }){
    bool _isShorter = false;

    if (_TextCheck.isEmpty(text) == true || length == null){
      _isShorter = true;
    }
    else {
      _isShorter = text!.length < length;
    }

    return _isShorter;
  }
  // --------------------
  /// AI TESTED
  static bool stringContainsSubString({
    required String? string,
    required String? subString,
  }) {
    bool _itContainsIt = false;

    if (string != null && subString != null) {
      if (string.toLowerCase().contains(subString.toLowerCase()) == true) {
        _itContainsIt = true;
      }
    }

    return _itContainsIt;
  }
  // --------------------
  /// AI TESTED
  static bool isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
}

void _asyncInSync(Function? asynchronous) {

  if (asynchronous != null){

    Future<void> _start() async {}

    _start().then((_) async {
      await asynchronous();
    });

  }

}

bool _setNotifier({
  required ValueNotifier<dynamic>? notifier,
  required bool mounted,
  required dynamic value,
  bool addPostFrameCallBack = false,
  Function? onFinish,
  bool shouldHaveListeners = false,
  String? invoker,
}){
  bool _done = false;

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');

    if (notifier != null){

      if (invoker != null){
        _blog('-> setNotifier($invoker) : $value != <${notifier.value.runtimeType}>${notifier.value} ? ${value != notifier.value}');
      }

      if (value != notifier.value){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value  = value;
            if(onFinish != null){
              onFinish();
            }
            _done = true;
          }

        }

      }

    }

  }

  return _done;
}

class _DialogLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _DialogLayout({
    required this.child,
    required this.onBack,
    // this.exitDirection = DismissiblePageDismissDirection.down,
    this.swipeDownDismiss = true,
    this.backgroundColor,
  });
  // --------------------
  final Widget child;
  // final DismissiblePageDismissDirection exitDirection;
  final bool swipeDownDismiss;
  final Function onBack;
  final Color? backgroundColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return GestureDetector(
      onTap: () => onBack(),
      child: Material(
        color: backgroundColor,
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: child,
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

abstract class _TextMod {
  // --------------------
  /// AI TESTED
  static String? removeTextBeforeLastSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result = text;

    if (_TextCheck.isEmpty(text) == false){

      final bool _textContainsChar = _TextCheck.stringContainsSubString(
        string: text,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {

        final int _position = _result!.lastIndexOf(specialCharacter);

        _result = text == null ? null
            :
        (_position != -1) ? text.substring(_position + 1, text.length)
            :
        text;
      }

    }

    return _result;
  }

}

abstract class _Booler {
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool boolIsTrue(dynamic value){
    bool _output = false;

    if (value != null && value is bool){
      _output = value;
    }

    return _output;
  }
// -----------------------------------------------------------------------------
}

void _blog(dynamic msg){

  assert((){
    if (kDebugMode) {
      debugPrint(msg?.toString());
    }
    return true;
  }(), '_');

}
