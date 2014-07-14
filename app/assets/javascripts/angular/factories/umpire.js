main.factory('Umpire', ['$http', function($http) {


	return {
		all: function(callback) {
			$http.get('/api/umpires')
				.success(callback)
		},

		show: function(id, callback) {
			$http.get('/api/umpires/' + id)
				.success(callback)
		},

		showYear: function(year, callback) {
			$http.get('/api/umpires/year/' + year)
				.success(callback)
		}
	}
}])