main.controller('GameController', ['$scope','$routeParams', 'Game', function($scope, $routeParams, Game) {

	var year = $routeParams.year
	var month = $routeParams.month
	var day = $routeParams.day

	Game.show(year, month, day, function(data) {
		$scope.homeTeam = data.homeTeam
		$scope.awayTeam = data.awayTeam
		$scope.pitch = data.pitch
		$scope.umpire = data.umpire
		$scope.umpireId = data.umpire_id
		$scope.game = data.game
		}
	)


}])