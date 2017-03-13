import angular from 'angular';
import navbar from './components/navbar';
import hero from './components/hero';
import turnoversForm from './components/turnoversForm';
import turnoversList from './components/turnoversList';

// import '../style/app.css';
import 'bulma/css/bulma.css';

class AppCtrl {
    constructor() {
      console.log('loading....!');
      this.github_url = 'https://github.com/waynelai614/ror-practice/tree/dev/wayne/wayne/stock_api_server';
      this.data_source_url = 'http://stock.wearn.com/qua.asp';
      this.turnovers = [
          {
              "created_at": "2017-03-10T13:02:42+08:00",
              "id": 101,
              "stock_change": 0.26,
              "stock_closing_today": 8.64,
              "stock_closing_yesterday": 8.38,
              "stock_code": 6116,
              "stock_company_uri": "http://stock.wearn.com/a6116.html",
              "stock_highest_price": 9.12,
              "stock_lowest_price": 8.64,
              "stock_name": "\u5f69\u6676",
              "stock_opening_price": 8.8,
              "stock_quote_change": 3.1,
              "stock_volume": 305491,
              "updated_at": "2017-03-10T13:02:42+08:00"
          }, {
              "created_at": "2017-03-10T13:02:42+08:00",
              "id": 102,
              "stock_change": 0.35,
              "stock_closing_today": 12.25,
              "stock_closing_yesterday": 11.9,
              "stock_code": 2344,
              "stock_company_uri": "http://stock.wearn.com/a2344.html",
              "stock_highest_price": 12.6,
              "stock_lowest_price": 12.2,
              "stock_name": "\u83ef\u90a6\u96fb",
              "stock_opening_price": 12.4,
              "stock_quote_change": 2.94,
              "stock_volume": 103725,
              "updated_at": "2017-03-10T13:02:42+08:00"
          }
      ]
    }

    $onInit() {
      console.log('init!');
    }
}

const MODULE_NAME = 'app';

angular.module(MODULE_NAME, [])
  .component('app', {
    template: require('./app.html'),
    controller: AppCtrl,
    controllerAs: 'app'
  })
  .component('navbar', navbar)
  .component('hero', hero)
  .component('turnoversForm', turnoversForm)
  .component('turnoversList', turnoversList);

export default MODULE_NAME;
