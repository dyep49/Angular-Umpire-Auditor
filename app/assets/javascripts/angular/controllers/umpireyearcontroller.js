main.controller('UmpireYearRankingController', ['$scope', 'Umpire', '$routeParams', function($scope, Umpire, $routeParams) {

  $scope.year = $routeParams.year

  Umpire.showYear($scope.year, function(data) {
    $scope.umpires = data
  })

}])