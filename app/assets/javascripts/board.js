
var stockModule = angular.module("stockApp", []);

// index
stockModule.controller("stockTable", function ($scope, $http) {
  $http.get("/api/v1/stocks")
  .then(function (response) {
    $scope.todaysTurnovers = response.data.data;
  });
});

// show
stockModule.controller("stockTableByCode", function ($scope, $http, $location) {
  $scope.codePath = $location.absUrl().match(/([^\/]*)\/*$/)[1];
  $http.get("/api/v1/stocks/sort?code=" + $scope.codePath)
    .then(function (response) {
      $scope.todaysTurnovers = response.data.data;
  });
});
