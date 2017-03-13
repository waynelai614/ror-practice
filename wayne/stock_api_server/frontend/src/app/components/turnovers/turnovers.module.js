import angular from 'angular';

import turnoversForm from './turnoversForm/turnoversForm.component';
import turnoversList from './turnoversList/turnoversList.component';

export default angular
  .module('components.turnovers', [])
  .component('turnoversForm', turnoversForm)
  .component('turnoversList', turnoversList)
  .name;
