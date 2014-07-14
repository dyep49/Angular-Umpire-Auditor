main.controller('DayController', ['$scope', 'Day', function($scope, Day) {

    Day.all(function(data) {
      console.log(data)
      $scope.days = data
    })




}])