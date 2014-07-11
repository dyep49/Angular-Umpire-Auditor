main.factory('Team', ['$http', function($http) {


  return {
    all: function(callback) {
      $http.get('/api/teams')
        .success(callback)
    },

    show: function(id, callback) {
      $http.get('/api/teams/' + id)
        .success(callback)
    }
  }
}])