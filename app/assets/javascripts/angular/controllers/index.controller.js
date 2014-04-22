main.controller('IndexController', ['$scope', 'Game', function($scope, Game) {

	Game.worstCall(function(data) {
		$scope.homeTeam = data.homeTeam
		$scope.awayTeam = data.awayTeam
		$scope.pitch = data.pitch
		$scope.umpire = data.umpire
		$scope.game = data.game
	})

}])