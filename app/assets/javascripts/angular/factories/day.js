main.factory('Day', ['$http', function($http) {
	{
		return {
			all: function(callback) {
				return $http.get('/api/days')
					.success(callback)
			},

			dates: function() {
				return $http.get('/api/days/dates')
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
					  	return parsedDate
						})
						return dates
					})
			}
		}
	}	

}])