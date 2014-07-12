main.factory('Day', ['$http', function($http) {
	{
		return {
			all: function() {
				return $http.get('/api/days')
					.then(function(result) {
						// var dateArray = []
						// result.data.forEach(function(game) {
						// 	var gameDate = new Date(game.game_date)
					 //  	var parsedDate = '' + gameDate.getYear() + '' + gameDate.getMonth() + '' + gameDate.getDate()
						// 	dateArray.push(parsedDate)
						// })
						dates = result.data.map(function(day) {
							day = new Date(day)
					  	var parsedDate = '' + day.getYear() + '' + day.getMonth() + '' + day.getDate()	
					  	console.log(parsedDate)
					  	return parsedDate
						})
						return dates
					})
			}
		}
	}	

}])