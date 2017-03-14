const API_HOST = 'http://0.0.0.0:3000';

class TurnoverService {
  constructor($http) {
    this.$http = $http;
  }

  getDates() {
    return this.$http.get(`${API_HOST}/api/stock/date`);
  }

  getByParams(params = {}) {
    if (!params.codes) delete params.codes;
    if (!params.date) delete params.date;
    return this.$http.get(`${API_HOST}/api/stock.json`, { params });
  }
  
  getTodaysTurnovers() {
    return this.getByParams();
  }
}

export default TurnoverService;
