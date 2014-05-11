main.controller('GameController', ['$scope','$routeParams', '$location', 'Game', function($scope, $routeParams, $location, Game) {

	var year = $routeParams.year
	var month = $routeParams.month
	var day = $routeParams.day

	Game.show(year, month, day, function(data) {
		$scope.homeTeam = data.homeTeam
		$scope.awayTeam = data.awayTeam
		$scope.pitch = data.pitch * 12
		$scope.umpire = data.umpire
		$scope.umpireId = data.umpire_id
		$scope.game = data.game
		}
	)

	$scope.dt = null

	$scope.today = Date()

  $scope.disabled = function(date, mode) {
    return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) );
  };


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