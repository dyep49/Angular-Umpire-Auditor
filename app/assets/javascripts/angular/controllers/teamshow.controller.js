main.controller('TeamShowController', ['$scope', 'Team', '$routeParams', '$filter', function($scope, Umpire, $routeParams, $filter) {

  Team.show($routeParams.id, function(data){
    var games = data.games
    games.forEach(function(game) {
      // game.game_date = $filter('date')(game.game_date, 'longDate')
    })
    
    $scope.games = data.games
    $scope.umpire = data.umpire
  })
  

}])