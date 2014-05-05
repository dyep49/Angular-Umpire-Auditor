main.factory('Day', ['$http', function($http) {
	{
		return {
			all: function() {
				return $http.get('/api/days')
					.then(function(result) {
						var dateArray = []
						result.data.forEach(function(game) {
							var gameDate = new Date(Date.parse(game.game_date))
					  	var parsedDate = '' + gameDate.getYear() + '' + gameDate.getMonth() + '' + gameDate.getDate()
							dateArray.push(parsedDate)
						})
						return dateArray
					})
			}
		}
	}	

}])