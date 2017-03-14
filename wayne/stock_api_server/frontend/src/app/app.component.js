// load css file in order
// TODO: css-module
import 'bulma/css/bulma.css';
import './components/navbar/nabvar.css';
import './components/turnover/turnoverList/turnoverList.css';
import './app.css';

const DEFAULT_STATE = {
  codes: '',
  date: '',
  sort: 'stock_volume',
  direction: 'direction'
};

class AppComponent {
  constructor(turnoverService) {
    'ngInject';
    this.turnoverService = turnoverService;
  }

  $onInit() {
    this.link = {
      github_url: 'https://github.com/waynelai614/ror-practice/tree/dev/wayne/wayne/stock_api_server',
      data_source_url: 'http://stock.wearn.com/qua.asp'
    };
    this.state = DEFAULT_STATE;
    this.turnovers = [];
    this.avaliable_date = [];

    this.turnoverService.getTodaysTurnovers().then(response => this.turnovers = response.data);
    this.turnoverService.getDates().then(response => this.avaliable_date = response.data);
  }

  getByParams({ params }) {
    if (!params) return;
    this.turnoverService.getByParams(params).then(response => this.turnovers = response.data);
    this.state = Object.assign({}, this.state, DEFAULT_STATE, params);
  }
}

export default {
  template: require('./app.html'),
  controller: AppComponent,
  controllerAs: 'app'
};
