import angular from 'angular';
import smartTable from 'angular-smart-table';
import turnoverList from './turnoverList.component';

export default angular
  .module('components.turnoverList', [smartTable])
  .run(['$templateCache', ($templateCache) => {
    $templateCache.put('template/pagination.html',
      require('./pagination.html')
    )
  }])
  .config((stConfig) => {
    stConfig.pagination.template = 'template/pagination.html';
  })
  .component('turnoverList', turnoverList)
  .name;
