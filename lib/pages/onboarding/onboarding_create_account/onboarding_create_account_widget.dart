import 'package:be_local_app/Utils/be_plant_theme.dart';
import 'package:be_local_app/Utils/util.dart';
import 'package:be_local_app/Utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Utils/model.dart';
import '../../../components/custom_app_bar_widget.dart';
import 'onboarding_create_account_model.dart';
export 'onboarding_create_account_model.dart';

class OnboardingCreateAccountWidget extends StatefulWidget {
  const OnboardingCreateAccountWidget({super.key});

  @override
  State<OnboardingCreateAccountWidget> createState() =>
      _OnboardingCreateAccountWidgetState();
}

class _OnboardingCreateAccountWidgetState
    extends State<OnboardingCreateAccountWidget> {
  late final OnboardingCreateAccountModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool confirmPasswordVisibility;
  final TextEditingController confirmedpasswordController = TextEditingController();
  final FocusNode confirmedpasswordNode = FocusNode();
  late bool passwordVisibility;
  //add the user and the mongodb INSTANCE

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingCreateAccountModel());
    confirmPasswordVisibility = false;
    passwordVisibility = false;
    _model.fullNameTextController = TextEditingController();
    _model.fullNameFocusNode = FocusNode();

    _model.emailAddressTextController = TextEditingController();
    _model.emailAddressFocusNode = FocusNode();

    _model.passwordTextController = TextEditingController();
    _model.passwordFocusNode = FocusNode();


  }

  Future errorMessage(String message) async {
    return await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
          title: new Text(
            message,
            selectionColor: CupertinoColors.systemGrey,
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Lexend Deca', fontSize: 15),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: new Text('OK'),
            ),
          ]),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool emailConfirmed() {
    print(_model.emailAddressTextController.text);
    if (_model.emailAddressTextController.text.isEmpty) {
      errorMessage("Please write your email address!");
      return false;
    }
    if (isValidEmail(_model.emailAddressTextController.text) == false) {
      errorMessage("Please write a valid email address!");
      return false;
    } else
      return true;
  }

  bool firstNameConfirmed() {
    if (_model.fullNameTextController.text.isEmpty) {
      errorMessage("Please write your first name!");
      return false;
    } else
      return true;
  }

  bool lastNameConfirmed() {
    if (_model.fullNameTextController.text.isEmpty) {
      errorMessage("Please write your last name!");
      return false;
    } else
      return true;
  }


  bool confirmedPassword() {
    if (isPasswordSafe(_model.passwordTextController.text) == false) {
      return false;
    }
    if (_model.passwordTextController.text != confirmedpasswordController?.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Passwords don\'t match!',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  bool isPasswordSafe(String password) {
    // Check if password has at least one uppercase letter
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    if (hasUppercase == false) {
      errorMessage(
          "Your password should contain at least one uppercase letter");
    }
    // Check if password has at least one lowercase letter
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    if (hasLowercase == false) {
      errorMessage(
          "Your password should contain at least one lowercase letter");
    }
    // Check if password has at least one digit
    bool hasNumber = password.contains(new RegExp(r'[0-9]'));
    if (hasNumber == false) {
      errorMessage("Your password should contain at least one digit");
    }
    // Check if password has at least one symbol
    bool hasSymbol = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (hasSymbol == false) {
      errorMessage("Your password should contain at least one symbol");
    }
    // Check if all criteria are met
    return hasUppercase && hasLowercase && hasNumber && hasSymbol;
  }

  @override
  void dispose() {
    _model.dispose();
    confirmedpasswordController?.dispose();
    _model.emailAddressTextController?.dispose();
    _model.passwordTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: BePlantTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wrapWithModel(
                      model: _model.customAppbarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CustomAppbarWidget(
                        backButton: true,
                        actionButton: false,
                        actionButtonAction: () async {},
                        optionsButtonAction: () async {},
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Text(
                        'Create an account',
                        style: BePlantTheme.of(context).displaySmall.override(
                          fontFamily: 'Urbanist',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 18.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    'Full Name',
                                    style: BePlantTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _model.fullNameTextController,
                                  autofocus: false,
                                  autofillHints: const [AutofillHints.name],
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        BePlantTheme.of(context).primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: BePlantTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  style: BePlantTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.0,
                                  ),
                                  minLines: 1,
                                  cursorColor:
                                  BePlantTheme.of(context).primary,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 18.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    'Email',
                                    style: BePlantTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _model.emailAddressTextController,
                                  focusNode: _model.emailAddressFocusNode,
                                  autofocus: false,
                                  autofillHints: const [AutofillHints.email],
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        BePlantTheme.of(context).primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: BePlantTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  style: BePlantTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.0,
                                  ),
                                  minLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor:
                                  BePlantTheme.of(context).primary,
                                  validator: _model
                                      .emailAddressTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 18.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    'Password',
                                    style: BePlantTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _model.passwordTextController,
                                  focusNode: _model.passwordFocusNode,
                                  autofocus: false,
                                  autofillHints: const [AutofillHints.newPassword],
                                  textInputAction: TextInputAction.done,
                                  obscureText: !_model.passwordVisibility,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        BePlantTheme.of(context).primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: BePlantTheme.of(context)
                                        .secondaryBackground,
                                    suffixIcon: InkWell(
                                      onTap: () => safeSetState(
                                            () => _model.passwordVisibility =
                                        !_model.passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: BePlantTheme.of(context)
                                            .secondaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                  style: BePlantTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.0,
                                  ),
                                  cursorColor:
                                  BePlantTheme.of(context).primary,
                                  validator: _model
                                      .passwordTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 18.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    'Password',
                                    style: BePlantTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: confirmedpasswordController,
                                  focusNode: confirmedpasswordNode,
                                  autofocus: false,
                                  autofillHints: const [AutofillHints.newPassword],
                                  textInputAction: TextInputAction.done,
                                  obscureText: !_model.passwordVisibility,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        BePlantTheme.of(context).primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: BePlantTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: BePlantTheme.of(context)
                                        .secondaryBackground,
                                    suffixIcon: InkWell(
                                      onTap: () => safeSetState(
                                            () => _model.passwordVisibility =
                                        !_model.passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: BePlantTheme.of(context)
                                            .secondaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                  style: BePlantTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.0,
                                  ),
                                  cursorColor:
                                  BePlantTheme.of(context).primary,
                                  validator: _model
                                      .passwordTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: BLButtonWidget(
                        onPressed: () async {
                          //modify this
                          if (emailConfirmed() &&
                              confirmedPassword() &&
                              firstNameConfirmed()){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.blueGrey,
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Sucessfully added your info, please continue'),
                                ),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }
                          /*
                          logFirebaseEvent(
                              'ONBOARDING_CREATE_ACCOUNT_CREATE_ACCOUNT');
                          logFirebaseEvent('Button_validate_form');
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          logFirebaseEvent('Button_haptic_feedback');
                          HapticFeedback.lightImpact();
                          logFirebaseEvent('Button_auth');
                          GoRouter.of(context).prepareAuthEvent();

                          final user = await authManager.createAccountWithEmail(
                            context,
                            _model.emailAddressTextController.text,
                            _model.passwordTextController.text,
                          );
                          if (user == null) {
                            return;
                          }

                          await UsersRecord.collection.doc(user.uid).update({
                            ...createUsersRecordData(
                              displayName: _model.fullNameTextController.text,
                              diet: FFAppState().userDiet,
                            ),
                            ...mapToFirestore(
                              {
                                'allergens': FFAppState().userAllergens,
                                'ingredient_dislikes':
                                FFAppState().userIngredientDislikes,
                              },
                            ),
                          });

                          logFirebaseEvent('Button_navigate_to');

                          context.goNamedAuth('Dashboard', context.mounted);

                           */
                        },
                        text: 'Create Account',
                        options: BLButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: BePlantTheme.of(context).primary,
                          textStyle:
                          BePlantTheme.of(context).titleSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0.0,
                          ),
                          elevation: 0.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
