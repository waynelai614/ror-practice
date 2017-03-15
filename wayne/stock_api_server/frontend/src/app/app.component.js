// load css file in order
// TODO: css-module
import 'bulma/css/bulma.css';
import './components/navbar/nabvar.css';
import './components/turnover/turnoverList/turnoverList.css';
import './app.css';

const DEFAULT_STATE = {
  searchTerm: {
    codes: '',
    date: ''
  },
  table: {
    sort: {
      predicate: 'stock_volume',
      reverse: true
    }
  },
  turnovers: [],
  avaliable_date: [],
  link: {
    github_url: 'https://github.com/waynelai614/ror-practice/tree/dev/wayne/wayne/stock_api_server',
    data_source_url: 'http://stock.wearn.com/qua.asp',
    download_url: ''
  }
};

class AppComponent {
  constructor(turnoverService) {
    'ngInject';
    this.turnoverService = turnoverService;
  }

  $onInit() {
    // copy the default state object
    this.state = Object.assign({}, DEFAULT_STATE);

    this.turnoverService.getTodaysTurnovers().then(response => this.state.turnovers = response.data);
    this.turnoverService.getDates().then(response => this.state.avaliable_date = response.data);
  }

  getByParams({ params }) {
    if (!params) return;
    this.turnoverService.getByParams(params).then(response => this.state.turnovers = response.data);
    this.state.searchTerm = Object.assign({}, this.state.searchTerm, DEFAULT_STATE.searchTerm, params);
  }

  updateTableState(tableState) {
    if (!tableState) return;
    this.state.table = Object.assign({}, this.state.table, tableState);
  }
}

export default {
  template: require('./app.html'),
  controller: AppComponent,
  controllerAs: 'app'
};
