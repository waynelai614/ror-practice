
let stockModule = angular.module('stockApp', []);

// service: set API path
stockModule.service('dataService', function ($http) {
  let urlBase = '/api/v1/stocks';
  this.getToday = function () {
    return $http.get(urlBase);
  };
  this.getByDate = function (date) {
    return $http.get(urlBase + '/sort?date=' + date);
  };
  this.getByCode = function (code) {
    return $http.get(urlBase + '/sort?code=' + code);
  };
  this.getByDateCode = function (date, code) {
    return $http.get(urlBase + '/sort?date=' + date + '&code=' + code);
  };
});

// index, path:/board
stockModule.controller('stockTable', function ($scope, dataService) {
  $scope.thNames = [
    '排', '代號', '名稱', '開盤價', '最高價', '最低價', '昨收盤', '今收盤', '成交量', '漲跌', '漲跌幅'
  ]
  dataService.getToday().then(function (response) {
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
    dataService.getByDate($scope.date).then(function (response) {
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
      dataService.getByDateCode($scope.date, $scope.code).then(function (response) {
        $scope.turnoversByDate = response.data.data
      });
    }
  };
});

// show, path:/board/XXXX
// get url last segment as stock code params
stockModule.controller('stockTableByCode', function ($scope, $location, dataService) {
  $scope.thNames = [
    '排', '日期', '名稱', '開盤價', '最高價', '最低價', '昨收盤', '今收盤', '成交量', '漲跌', '漲跌幅'
  ]
  $scope.codePath = $location.absUrl().match(/([^\/]*)\/*$/)[1];
  dataService.getByCode($scope.codePath).then(function (response) {
    $scope.todaysTurnovers = response.data.data;
  });
});

// template: common head
stockModule.directive('headTitle', function () {
  return {
    restrict: 'E',
    template: `
      <div class="width-wrapper">
        <h1>
          <a href="/">Stock Board</a>
          <span ng-if="codePath"> - 代號 {{ codePath }} <span>
        </h1>
      </div>`,
  };
});
// template: common table
stockModule.directive('customTable', function () {
  return {
    restrict: 'E',
    scope: {
      thNames: '=',
      turnoversName: '=',
      order: '=',
      codePath: '='
    },
    template: `
    <table>
        <thead>
          <tr>
            <th ng-repeat="thName in thNames">{{ thName }}</th>
          </tr>
        </thead>
        <tbody>
          <tr ng-repeat="(key, todaysTurnover) in  turnoversName | orderBy: order">
            <td>{{ key+1 }}</td>
            <td ng-if="!codePath">
              <a ng-href="/board/{{ todaysTurnover.stock_code }}" target="_blank">
                {{ todaysTurnover.stock_code }}
              </a>
            </td>
            <td ng-if="codePath">
              {{ todaysTurnover.created_at | date:'yyyy-MM-dd'}}
            </td>
            <td>
              <a ng-href="{{ todaysTurnover.stock_company_url }}" target="_blank">
                {{ todaysTurnover.stock_name }}
              </a>
            </td>
            <td>{{ todaysTurnover.stock_opening_price }}</td>
            <td>{{ todaysTurnover.stock_highest_price }}</td>
            <td>{{ todaysTurnover.stock_lowest_price }}</td>
            <td>{{ todaysTurnover.stock_closing_yesterday }}</td>
            <td>{{ todaysTurnover.stock_closing_today }}</td>
            <td>{{ todaysTurnover.stock_volumn }}</td>
            <td>
              <div class= "go-up" ng-if="todaysTurnover.stock_change > 0">
                <font>▲</font>
                <font>{{ todaysTurnover.stock_change }}</font>
              </div>
              <div class= "go-down" ng-if="todaysTurnover.stock_change < 0">
                <font>▼</font>
                <font>{{ todaysTurnover.stock_change }}</font>
              </div>
              <div ng-if="todaysTurnover.stock_change == 0">
                <font>－</font>
                <font>{{ todaysTurnover.stock_change }}</font>
              </div>
            </td>
            <td>{{ todaysTurnover.stock_quote_change }}％</td>
          </tr>
        </tbody>
      </table>`
  };
});