class IUseCase {
  call() {}
}

class IGetAllCoursesUseCase extends IUseCase {}

class IGetBeginnerCoursesUseCase extends IUseCase {}

class IGetLaunchedSessionUseCase extends IUseCase {}

class IGetStatisticsUseCase extends IUseCase {}

class IStopLaunchedSessionUseCase {
  call(int sessionId) {}
}
