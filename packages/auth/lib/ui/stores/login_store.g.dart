// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(
            () => super.canSubmit,
            name: '_LoginStore.canSubmit',
          ))
          .value;

  late final _$_isSubmittingAtom = Atom(
    name: '_LoginStore._isSubmitting',
    context: context,
  );

  bool get isSubmitting {
    _$_isSubmittingAtom.reportRead();
    return super._isSubmitting;
  }

  @override
  bool get _isSubmitting => isSubmitting;

  @override
  set _isSubmitting(bool value) {
    _$_isSubmittingAtom.reportWrite(value, super._isSubmitting, () {
      super._isSubmitting = value;
    });
  }

  late final _$_emailAtom = Atom(name: '_LoginStore._email', context: context);

  String get email {
    _$_emailAtom.reportRead();
    return super._email;
  }

  @override
  String get _email => email;

  @override
  set _email(String value) {
    _$_emailAtom.reportWrite(value, super._email, () {
      super._email = value;
    });
  }

  late final _$_passwordAtom = Atom(
    name: '_LoginStore._password',
    context: context,
  );

  String get password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  String get _password => password;

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  late final _$_showPasswordAtom = Atom(
    name: '_LoginStore._showPassword',
    context: context,
  );

  bool get showPassword {
    _$_showPasswordAtom.reportRead();
    return super._showPassword;
  }

  @override
  bool get _showPassword => showPassword;

  @override
  set _showPassword(bool value) {
    _$_showPasswordAtom.reportWrite(value, super._showPassword, () {
      super._showPassword = value;
    });
  }

  late final _$_errorMessageAtom = Atom(
    name: '_LoginStore._errorMessage',
    context: context,
  );

  String? get errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  String? get _errorMessage => errorMessage;

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$_isAuthenticatedAtom = Atom(
    name: '_LoginStore._isAuthenticated',
    context: context,
  );

  bool get isAuthenticated {
    _$_isAuthenticatedAtom.reportRead();
    return super._isAuthenticated;
  }

  @override
  bool get _isAuthenticated => isAuthenticated;

  @override
  set _isAuthenticated(bool value) {
    _$_isAuthenticatedAtom.reportWrite(value, super._isAuthenticated, () {
      super._isAuthenticated = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    '_LoginStore.login',
    context: context,
  );

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$_LoginStoreActionController = ActionController(
    name: '_LoginStore',
    context: context,
  );

  @override
  void setEmail(String email) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
      name: '_LoginStore.setEmail',
    );
    try {
      return super.setEmail(email);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
      name: '_LoginStore.setPassword',
    );
    try {
      return super.setPassword(password);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
      name: '_LoginStore.toggleShowPassword',
    );
    try {
      return super.toggleShowPassword();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
canSubmit: ${canSubmit}
    ''';
  }
}
