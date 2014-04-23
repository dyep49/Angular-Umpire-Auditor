main.controller('UmpireController', ['$scope', 'Umpire', function($scope, Umpire) {


	Umpire.all(function(data) {
		$scope.umpires = data
	})








}])