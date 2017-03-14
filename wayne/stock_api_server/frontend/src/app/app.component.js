// load css file in order
// TODO: css-module
import 'bulma/css/bulma.css';
import './components/navbar/nabvar.css';
import './components/turnover/turnoverList/turnoverList.css';

class AppCtrl {
    constructor(turnoverService) {
      this.github_url = 'https://github.com/waynelai614/ror-practice/tree/dev/wayne/wayne/stock_api_server';
      this.data_source_url = 'http://stock.wearn.com/qua.asp';
      this.turnoverService = turnoverService;
    }

    getTurnovers() {
      console.log('call getTurnovers');
      this.turnoverService
        .getData()
        .then(response => this.turnovers = response.data);
    }

    $onInit() {
      this.getTurnovers();
    }
}

export default {
  template: require('./app.html'),
  controller: AppCtrl,
  controllerAs: 'app'
};
