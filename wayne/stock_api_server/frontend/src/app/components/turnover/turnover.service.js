const API_HOST = 'http://0.0.0.0:3000';

class TurnoverService {
  constructor($http) {
    this.$http = $http;
  }

  getDates() {
    return this.$http.get(`${API_HOST}/api/stock/date`);
  }

  getTodaysTurnovers() {
    return this.$http.get(`${API_HOST}/api/stock.json`);
  }

  getByParams(params) {
    if (!params.codes) delete params.codes;
    return this.$http.get(`${API_HOST}/api/stock.json`, { params });
  }
}

export default TurnoverService;
