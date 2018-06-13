
var stockModule = angular.module('stockApp', []);

// index
stockModule.controller('stockTable', function ($scope, $http) {
  $http.get('/api/v1/stocks')
  .then(function (response) {
    // get today's turnovers
    $scope.turnoversByDate = response.data.today;

    // date dropdown select data
    // only compare ten words from beginning
    // init date dropdown select
    const allDate = response.data.date
    $scope.turnoversDate = [...new Set(allDate.map(date => date.created_at.substring(0, 10)))];
    $scope.date = $scope.turnoversDate.slice(-1)[0];

    // init volumn rank dropdown select
    $scope.volumnRank = null;

    // stock code dropdown select data
    $scope.allStockCode = $scope.turnoversByDate.map(stock => stock.stock_code);
  });

  // date dropdown select onchange event
  // sort by date
  $scope.dateSelected = function () {
    $http.get('/api/v1/stocks/sort?date=' + $scope.date)
    .then(function (response) {
      $scope.turnoversByDate = response.data.data
    });
    // reset stock code dropdown select
    // reset volumn rank dropdown select
    $scope.code = null;
    $scope.volumnRank = null;
  };
 
  // stock code dropdown select onchange event
  // sort by date and stock code
  $scope.codeSelected = function () {
    if (!$scope.code) {
      $scope.dateSelected();
    } else {
      $http.get('/api/v1/stocks/sort?date=' + $scope.date + '&code=' + $scope.code)
      .then(function (response) {
        $scope.turnoversByDate = response.data.data
      });
    }
  };
});

// show
// get url last segment as stock code params
stockModule.controller('stockTableByCode', function ($scope, $http, $location) {
  $scope.codePath = $location.absUrl().match(/([^\/]*)\/*$/)[1];
  $http.get('/api/v1/stocks/sort?code=' + $scope.codePath)
    .then(function (response) {
      $scope.todaysTurnovers = response.data.data;
  });
});
