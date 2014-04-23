main.controller('IndexController', ['$scope', '$location', 'Game', function($scope, $location, Game) {

	Game.worstCall(function(data) {
		$scope.homeTeam = data.homeTeam
		$scope.awayTeam = data.awayTeam
		$scope.pitch = data.pitch
		$scope.umpire = data.umpire
		$scope.game = data.game
	})

	$scope.dt = null

	$scope.today = Date()

	$scope.submitDate = function() {
		date = $scope.dt
		if(date) {
			year = date.getFullYear()
			month = date.getMonth()
			day = date.getDay()
			$location.path('/games/date/' + year + '/' + month + '/' + day)			
		}
	}

}])