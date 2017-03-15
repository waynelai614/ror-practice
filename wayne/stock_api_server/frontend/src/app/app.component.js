// load css file in order
// TODO: css-module
import 'bulma/css/bulma.css';
import './components/navbar/nabvar.css';
import './components/turnover/turnoverList/turnoverList.css';
import './app.css';

const DEFAULT_STATE = {
  isLoading: false,
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
    this.state.isLoading = true;

    this.turnoverService.getByParams(params).then(response => {
      this.state.turnovers = response.data;
      this.state.isLoading = false;
    });
    this.state.searchTerm = Object.assign({}, this.state.searchTerm, DEFAULT_STATE.searchTerm, params);
    // update download link when searchTerm change
    this.updateDownloadLink();
  }

  updateTableState(tableState) {
    if (!tableState) return;
    this.state.table = Object.assign({}, this.state.table, tableState);
    // update download link when table state change
    this.updateDownloadLink();
  }

  updateDownloadLink() {
    const { codes, date } = this.state.searchTerm;
    let params = [codes, date];
    // check state.table.sort obj is empty or not
    if (Object.keys(this.state.table.sort).length !== 0 ) {
      const { predicate, reverse } = this.state.table.sort;
      let direction = reverse == true ? 'desc' : 'asc';
      params.push(predicate, direction);
    }
    this.state.link.download_url = this.turnoverService.getDownloadLink(...params);
  }
}

export default {
  template: require('./app.html'),
  controller: AppComponent,
  controllerAs: 'app'
};
