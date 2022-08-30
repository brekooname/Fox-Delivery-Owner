abstract class FoxStates{}

class FoxInitialState extends FoxStates{}

class FoxChangeBotNavBare extends FoxStates{}
class FoxSetSelectedDateLoadingState extends FoxStates{}
class FoxSetSelectedDateSuccessState extends FoxStates{}

class FoxGetOrdersLoadingState extends FoxStates{}
class FoxGetOrdersSuccessState extends FoxStates{}
class FoxGetOrdersErrorState extends FoxStates{}

class FoxCompleteOrderLoadingState extends FoxStates{}
class FoxCompleteOrderSuccessState extends FoxStates{}
class FoxCompleteOrderErrorState extends FoxStates{}

class FoxGetProblemsLoadingState extends FoxStates{}
class FoxGetProblemsSuccessState extends FoxStates{}
class FoxGetProblemsErrorState extends FoxStates{}

class FoxImagePickedSuccessState extends FoxStates{}
class FoxImagePickedErrorState extends FoxStates{}

class FoxRemoveOfferImageState extends FoxStates{}

class FoxCreateOfferLoadingState extends FoxStates{}
class FoxCreateOfferSuccessState extends FoxStates{}
class FoxCreateOfferErrorState extends FoxStates{}
