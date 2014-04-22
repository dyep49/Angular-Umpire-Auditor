var main = angular.module('main', ['ngResource', 'ngAnimate', 'ngRoute']);

main.config([   "$httpProvider", function(provider) {  return provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');   } ]);

main.config(function($routeProvider) {
	$routeProvider.
		when('/', {
			templateUrl: 'templates/index.html',
			controller: 'IndexController'
		}).
		when('/games/date/:year/:month/:day', {
			templateUrl: 'templates/games.html',
			controller: 'GameController'
		}).
		otherwise({
			redirectTo: '/'
		})
})