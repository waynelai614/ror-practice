const API_HOST = 'http://0.0.0.0:3000'

class TurnoverService {
    constructor($http) {
      this.$http = $http;
    }

    getDates() {
      return this.$http.get(`${API_HOST}/api/stock/date`);
    }

    getData() {
      return this.$http.get(`${API_HOST}/api/stock.json`);
    }

    findByStockCode(code) {
      return this.$http.get(`${API_HOST}/api/stock.json`, {
        params: {
          codes: '1314,2303'
        }
      });
    }

}

export default TurnoverService;
