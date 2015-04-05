main.filter('ordinalSuffix', function() {
  return function(number) {
    var suffixes = ["th", "st", "nd", "rd"];
    var relevantDigits = (number < 30) ? number % 20 : number % 30;
    var suffix = (relevantDigits <= 3) ? suffixes[relevantDigits] : suffixes[0];
    return number + suffix
  }
})