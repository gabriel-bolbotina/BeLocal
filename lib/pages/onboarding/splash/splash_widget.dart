import 'package:be_local_app/Utils/be_plant_theme.dart';
import 'package:be_local_app/pages/onboarding/onboarding_create_account/onboarding_create_account_widget.dart';
import 'package:be_local_app/pages/onboarding/onboarding_slideshow/onboarding_infos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../Utils/model.dart';
import 'splash_screen.dart';
import '../../../Utils/widget.dart';
export 'splash_screen.dart';
import 'package:rive/rive.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  late SplashModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashModel());

    //logFirebaseEvent('screen_view', parameters: {'screen_name': 'Splash'});
  }

  @override
  void dispose() {
    _model.dispose();

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        child: RiveAnimation.asset(
                          'assets/rive/farmer-3.riv',
                        ),
                        decoration: BoxDecoration(
                          color:Colors.transparent,
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Be',
                                style: BePlantTheme.of(context)
                                    .displaySmall
                                    .override(
                                  fontFamily: 'Urbanist',
                                  letterSpacing: 0.0,
                                ),
                              ),
                              TextSpan(
                                text: 'Local',
                                style: BePlantTheme.of(context)
                                    .displaySmall
                                    .override(
                                  fontFamily: 'Urbanist',
                                  color:
                                  BePlantTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                ),
                              )
                            ],
                            style: BePlantTheme.of(context)
                                .displaySmall
                                .override(
                              fontFamily: 'Urbanist',
                              fontSize: 32.0,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BLButtonWidget(
                      onPressed: () async {
                        /*
                        logFirebaseEvent('SPLASH_PAGE_GET_STARTED_BTN_ON_TAP');
                        logFirebaseEvent('Button_haptic_feedback');
                        HapticFeedback.lightImpact();
                        logFirebaseEvent('Button_navigate_to');
                        */
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OnboardingSlideshowWidget(),),);

                      },
                      text: 'Get Started',
                      options: BLButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: BePlantTheme.of(context).success,
                        textStyle:
                        BePlantTheme.of(context).titleSmall.override(
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0.0,
                        ),
                        elevation: 0.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        /*
                        logFirebaseEvent('SPLASH_PAGE_Column_9mc7ub12_ON_TAP');
                        logFirebaseEvent('Column_navigate_to');

                        context.pushNamed('SignIn');

                         */
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 24.0),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already a member?  ',
                                    style: BePlantTheme.of(context)
                                        .bodySmall
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: BePlantTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                                style: BePlantTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
