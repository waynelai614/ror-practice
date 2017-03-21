import angular from 'angular';
import smartTable from 'angular-smart-table';
import turnoverList from './turnoverList.component';

export default angular
  .module('components.turnoverList', [smartTable])
  .run(['$templateCache', ($templateCache) => {
    $templateCache.put('template/pagination.html',
      require('./pagination.html')
    );
  }])
  .config((stConfig) => {
    'ngInject';
    stConfig.pagination.template = 'template/pagination.html';
  })
  .directive('stPersist', () => {
    return {
      require: '^stTable',
      scope: {
        onUpdateTableState: '&'
      },
      link: (scope, element, attr, ctrl) => {
        // update the table state every time it changes
        scope.$watch(() => ctrl.tableState()
        , (newValue, oldValue) => {
          if (newValue !== oldValue) {
            scope.onUpdateTableState({ tableState: newValue });
          }
        }, true);
      }
    };
  })
  .component('turnoverList', turnoverList)
  .name;
