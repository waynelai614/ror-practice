class TurnoverService {
    constructor($http) {
      this.$http = $http;
    }
    getData() {
      return this.$http.get('http://0.0.0.0:3000/api/stock.json');
    }
    findByStockCode(code) {
      return this.$http.get('http://0.0.0.0:3000/api/stock.json', {
        params: {
          codes: '1314,2303'
        }
      });
    }

}

export default TurnoverService;
