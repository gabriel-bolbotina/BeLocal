
import 'package:be_local_app/Utils/be_plant_theme.dart';
import 'package:be_local_app/Utils/util.dart';
import 'package:be_local_app/Utils/widget.dart';
import 'package:be_local_app/pages/onboarding/choose_user_type/user_type_slideshow.dart';
import 'package:be_local_app/pages/onboarding/onboarding_create_account/onboarding_create_account_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../Utils/animations.dart';
import '../../../Utils/model.dart';
import '../../../components/custom_app_bar_widget.dart';
import '../onboarding_address/address.dart';
import '../onboarding_slideshow/onboarding_infos_model.dart';

class UserTypeSlideshowWidget extends StatefulWidget {
  const UserTypeSlideshowWidget({super.key});

  @override
  State<UserTypeSlideshowWidget> createState() =>
      _UserTypeSlideshowWidgetState();
}

class _UserTypeSlideshowWidgetState extends State<UserTypeSlideshowWidget>
    with TickerProviderStateMixin {
  late UserTypeSlideshowModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserTypeSlideshowModel());
/*
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Onboarding_Slideshow'});

 */
    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
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
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: 500.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 50.0),
                                  child: PageView(
                                    controller: _model.pageViewController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          print("image tapped");
                                          print(_model.pageViewController?.page);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const OnboardingCreateAccountWidget(),),);


                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 32.0),
                                              child: Text(
                                                'Producător Local \n ',
                                                textAlign: TextAlign.center,
                                                style:
                                                BePlantTheme.of(context)
                                                    .displaySmall
                                                    .override(
                                                  fontFamily: 'Urbanist',
                                                  letterSpacing: 0.0,
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                              'textOnPageLoadAnimation1']!),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                              child: Image.asset(
                                                "assets/photos/distribution.png",
                                                height: 250.0,
                                                fit: BoxFit.fill,
                                              ).animateOnPageLoad(animationsMap[
                                              'imageOnPageLoadAnimation1']!),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 48.0, 0.0, 0.0),
                                              child: Text(
                                                'Adaugă, comercializează și vinde produse create și recoltate de către tine',
                                                textAlign: TextAlign.center,
                                                style:
                                                BePlantTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                              'textOnPageLoadAnimation2']!),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          print("image tapped");
                                          print(_model.pageViewController?.page);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const OnboardingCreateAccountWidget(),),);


                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 32.0),
                                              child: Text(
                                                'Utilizator Cumpărător',
                                                textAlign: TextAlign.center,
                                                style:
                                                BePlantTheme.of(context)
                                                    .displaySmall
                                                    .override(
                                                  fontFamily: 'Urbanist',
                                                  letterSpacing: 0.0,
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                              'textOnPageLoadAnimation3']!),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                              child: Image.asset(
                                                "assets/photos/vegetables.png",
                                                height: 250.0,
                                                fit: BoxFit.contain,
                                              ).animateOnPageLoad(animationsMap[
                                              'imageOnPageLoadAnimation2']!),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 48.0, 0.0, 0.0),
                                              child: Text(
                                                'Bucură-te de produse proaspete și recoltate din împrejurimi, descoperă un nou mod de a comandat produse locale',
                                                textAlign: TextAlign.center,
                                                style:
                                                BePlantTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                              'textOnPageLoadAnimation4']!),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 1.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: smooth_page_indicator
                                        .SmoothPageIndicator(
                                      controller: _model.pageViewController ??=
                                          PageController(initialPage: 0),
                                      count: 2,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) async {
                                        await _model.pageViewController!
                                            .animateToPage(
                                          i,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                        safeSetState(() {});
                                      },
                                      effect: smooth_page_indicator
                                          .ExpandingDotsEffect(
                                        expansionFactor: 3.0,
                                        spacing: 10.0,
                                        radius: 10.0,
                                        dotWidth: 10.0,
                                        dotHeight: 10.0,
                                        dotColor: BePlantTheme.of(context)
                                            .secondaryText,
                                        activeDotColor:
                                        BePlantTheme.of(context)
                                            .primaryText,
                                        paintStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: BLButtonWidget(
                        onPressed: () async {
                          /*
                          logFirebaseEvent(
                              'ONBOARDING_SLIDESHOW_CONTINUE_BTN_ON_TAP');
                          if (_model.pageViewCurrentIndex == 2) {
                            logFirebaseEvent('Button_haptic_feedback');
                            HapticFeedback.lightImpact();
                            logFirebaseEvent('Button_navigate_to');

                            context.pushNamed('Onboarding');
                          } else {
                            logFirebaseEvent('Button_haptic_feedback');
                            HapticFeedback.lightImpact();
                            logFirebaseEvent('Button_page_view');
                            await _model.pageViewController?.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }

                           */
                          if(_model.pageViewController?.page == 1.0){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OnboardingAddressWidget(),),);
                            print("mergem pe pagina de utilizator \n");
                          }
                          if(_model.pageViewController?.page == 0.0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (
                                  context) => const OnboardingCreateAccountWidget(),),);
                            print("mergem pe pagina de producator \n");
                          }
                        },
                        text: 'Continuă',
                        options: BLButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
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
                        showLoadingIndicator: false,
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
