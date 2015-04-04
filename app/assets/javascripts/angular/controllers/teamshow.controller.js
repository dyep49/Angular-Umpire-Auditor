main.controller('TeamShowController', ['$scope', 'Team', '$routeParams', '$filter', function($scope, Team, $routeParams, $filter) {

  Team.show($routeParams.id, function(data){
    $scope.games = data.games
    $scope.team = data.team
  })
  

}])