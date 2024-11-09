import 'package:be_local_app/Utils/model.dart';
import '../../../components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'address.dart' show OnboardingAddressWidget;

class OnboardingAddressModel
    extends BePlantModel<OnboardingAddressWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for customAppbar component.
  late CustomAppbarModel customAppbarModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
      pageViewController!.hasClients &&
      pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
  }
}
