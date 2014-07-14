main.directive('worstcall', [function() {
  return {
    restrict: 'E',
    scope: {
      callinfo: "=callinfo",
      umpire: "=umpire"
    },
    templateUrl: 'templates/worst_call.html'
  }
}])