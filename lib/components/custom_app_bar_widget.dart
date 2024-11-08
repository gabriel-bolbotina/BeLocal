import '../../../Utils/icon_button.dart';
import '../../../Utils/be_plant_theme.dart';
import '../../../Utils/util.dart';
import '../../../Utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Utils/model.dart';
import 'custom_app_bar.dart';
export 'custom_app_bar.dart';

class CustomAppbarWidget extends StatefulWidget {
  const CustomAppbarWidget({
    super.key,
    required this.backButton,
    bool? actionButton,
    this.actionButtonText,
    this.actionButtonAction,
    bool? optionsButton,
    required this.optionsButtonAction,
  })  : actionButton = actionButton ?? false,
        optionsButton = optionsButton ?? false;

  final bool? backButton;
  final bool actionButton;
  final String? actionButtonText;
  final Future Function()? actionButtonAction;
  final bool optionsButton;
  final Future Function()? optionsButtonAction;

  @override
  State<CustomAppbarWidget> createState() => _CustomAppbarWidgetState();
}

class _CustomAppbarWidgetState extends State<CustomAppbarWidget> {
  late CustomAppbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAppbarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.backButton ?? true)
          BeLocalIconButton(
            borderColor: BePlantTheme.of(context).secondaryBackground,
            borderRadius: 24.0,
            borderWidth: 1.0,
            buttonSize: 44.0,
            fillColor: BePlantTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: BePlantTheme.of(context).primaryText,
              size: 18.0,
            ),
            onPressed: () async {
              /*
              logFirebaseEvent('CUSTOM_APPBAR_keyboard_arrow_left_ICN_ON');
              logFirebaseEvent('IconButton_navigate_back');
              context.safePop();

               */
            },
          ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.actionButton)
              BLButtonWidget(
                onPressed: () async {
                  /*
                  logFirebaseEvent('CUSTOM_APPBAR_COMP_SAVE_BTN_ON_TAP');
                  logFirebaseEvent('Button_execute_callback');
                  await widget.actionButtonAction?.call();

                   */
                },
                text: valueOrDefault<String>(
                  widget.actionButtonText,
                  'Button',
                ),
                options: BLButtonOptions(
                  height: 44.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: BePlantTheme.of(context).primary,
                  textStyle: BePlantTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: BePlantTheme.of(context).primaryBackground,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 0.0,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            if (widget.optionsButton)
              BeLocalIconButton(
                borderColor: BePlantTheme.of(context).secondaryBackground,
                borderRadius: 24.0,
                borderWidth: 1.0,
                buttonSize: 44.0,
                fillColor: BePlantTheme.of(context).secondaryBackground,
                icon: FaIcon(
                  FontAwesomeIcons.ellipsisH,
                  color: BePlantTheme.of(context).primaryText,
                  size: 18.0,
                ),
                onPressed: () async {
                  /*
                  logFirebaseEvent('CUSTOM_APPBAR_COMP_ellipsisH_ICN_ON_TAP');
                  logFirebaseEvent('IconButton_execute_callback');
                  await widget.optionsButtonAction?.call();

                   */
                },
              ),
          ].divide(const SizedBox(width: 8.0)),
        ),
      ],
    );
  }
}
