main.controller('UmpireShowController', ['$scope', 'Umpire', '$routeParams', function($scope, Umpire, $routeParams) {

	Umpire.show($routeParams.id, function(data){
		$scope.games = data.games
		$scope.umpire = data.umpire
	})
	

}])