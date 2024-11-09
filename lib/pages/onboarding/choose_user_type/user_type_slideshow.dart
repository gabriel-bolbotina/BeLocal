import 'package:be_local_app/Utils/model.dart';
import 'package:be_local_app/pages/onboarding/choose_user_type/user_type_slideshow_widget.dart';
import '../../../components/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../onboarding_slideshow/onboarding_infos_widget.dart';

class UserTypeSlideshowModel
    extends BePlantModel<UserTypeSlideshowWidget> {
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
