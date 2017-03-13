import angular from 'angular';

import componentsModule from './components/components.module';
import appComponent from './app.component';
import turnoverService from './components/turnover/turnover.service';

const MODULE_NAME = 'app';

export default angular
  .module(MODULE_NAME, [componentsModule])
  .service('turnoverService', turnoverService)
  .component(MODULE_NAME, appComponent)
  .name;
