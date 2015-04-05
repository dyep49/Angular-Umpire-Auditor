main.factory('Game', ['$http', function($http) {

	return {
		worstCall: function(callback) {
			$http.get('/api/worst_call')
				.success(callback)
		},

		show: function(year, month, day, callback) {
			$http.get('/api/games/date/' + year + '/' + month + '/' + day)
				.success(callback)
		}
	}
	
}])