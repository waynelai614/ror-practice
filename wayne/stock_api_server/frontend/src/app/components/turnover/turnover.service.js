const API_HOST = 'http://0.0.0.0:3000';

class TurnoverService {
  constructor($http) {
    'ngInject';
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

  getDownloadLink(codes, date, sort='stock_volume', direction='desc') {
    let link = `${API_HOST}/api/stock.xlsx?sort=${sort}&direction=${direction}`;
    if (codes) link = link.concat(`&codes=${codes}`);
    if (date) link = link.concat(`&date=${date}`);
    return link;
  }
}

export default TurnoverService;
