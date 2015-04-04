main.directive('umpiretable', [function() {
  return {
    restrict: 'E',
    scope: {
      umpires: '=umpires'
    },
    templateUrl: 'templates/umpire_table.html'
  }
}])