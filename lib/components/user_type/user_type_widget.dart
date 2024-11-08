import 'package:be_local_app/Utils/be_plant_theme.dart';

import '../../Utils/model.dart';
import 'package:flutter/material.dart';
import 'user_type_model.dart';

class UserTypeWidget extends StatefulWidget {
  const UserTypeWidget({
    super.key,
    required this.dietType,
    required this.selectedDiet,
    required this.dietTagline,
    required this.action,
  });

  final String? dietType;
  final String? selectedDiet;
  final String? dietTagline;
  final Future Function()? action;

  @override
  State<UserTypeWidget> createState() => _UserTypeWidgetState();
}

class _UserTypeWidgetState extends State<UserTypeWidget> {
  late UserTypeWidget _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
   // _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => UserTypeModel());
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        /*
        logFirebaseEvent('DIET_ITEM_COMP_Container_f58tyizj_ON_TAP');
        logFirebaseEvent('Container_execute_callback');
        await widget.action?.call();

         */
      },
      child: Container(
        width: double.infinity,
        height: 44.0,
        decoration: BoxDecoration(
          color: widget.selectedDiet == widget.dietType
              ? BePlantTheme.of(context).primary
              : BePlantTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.dietType!,
                style: BePlantTheme.of(context).bodyMedium.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: widget.selectedDiet == widget.dietType
                      ? BePlantTheme.of(context).primaryBackground
                      : BePlantTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (widget.selectedDiet == widget.dietType)
                Text(
                  widget.dietTagline!,
                  style: BePlantTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: BePlantTheme.of(context).primaryBackground,
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
