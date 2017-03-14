import angular from 'angular';

import turnoverForm from './turnoverForm/turnoverForm.module';
import turnoverList from './turnoverList/turnoverList.module';

export default angular
  .module('components.turnover', [
    turnoverList,
    turnoverForm
  ])
  .name;
