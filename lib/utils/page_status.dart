abstract class PageStatus {
  const PageStatus();
}

class Initial extends PageStatus {
  const Initial();
}

class DataLoading extends PageStatus {}

class DataLoaded extends PageStatus {}

class DataLoadFailed extends PageStatus {}

class DataSubmitting extends PageStatus {}

class DataSubmitted extends PageStatus {}

class DataSubmitFailed extends PageStatus {}

class DataChecking extends PageStatus {}

class DataChecked extends PageStatus {}

class DataCheckFailed extends PageStatus {}

class DataSearching extends PageStatus {}

class DataSearched extends PageStatus {}

class DataSearchFailed extends PageStatus {}
