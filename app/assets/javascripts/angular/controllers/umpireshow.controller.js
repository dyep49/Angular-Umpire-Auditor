main.controller('UmpireShowController', ['$scope', 'Umpire', '$routeParams', '$filter', function($scope, Umpire, $routeParams, $filter) {

	Umpire.show($routeParams.id, function(data){
		var games = data.games
		games.forEach(function(game) {
			// game.game_date = $filter('date')(game.game_date, 'longDate')
		})
		
		$scope.games = data.games
		$scope.umpire = data.umpire
	})
	

}])

