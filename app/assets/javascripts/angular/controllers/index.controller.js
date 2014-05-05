main.controller('IndexController', ['$scope', '$location', 'Game', 'Day', function($scope, $location, Game, Day) {

	var dateArray = []

	Game.worstCall(function(data) {
		$scope.homeTeam = data.homeTeam
		$scope.awayTeam = data.awayTeam
		$scope.pitch = data.pitch
		$scope.umpire = data.umpire
		$scope.game = data.game
		$scope.umpireId = data.umpire_id
	})

	Day.all().then(function(data) {
		data.forEach(function(date) {
			dateArray.push(date)
		})
	  $scope.disabled = function(date, mode) {
	  	var gameDate = new Date(date)
	  	var parsedDate = '' + gameDate.getYear() + '' + gameDate.getMonth() + '' + gameDate.getDate()
	    return ( mode === 'day' && (dateArray.indexOf(parsedDate) === -1));
	  };
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