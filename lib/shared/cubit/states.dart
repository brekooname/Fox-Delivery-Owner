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