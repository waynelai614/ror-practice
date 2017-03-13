import angular from 'angular';

import turnoverForm from './turnoverForm/turnoverForm.component';
import turnoverList from './turnoverList/turnoverList.component';

export default angular
  .module('components.turnover', [])
  .component('turnoverForm', turnoverForm)
  .component('turnoverList', turnoverList)
  .name;
