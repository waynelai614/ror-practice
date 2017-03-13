import angular from 'angular';

import componentsModule from './components/components.module';
import appComponent from './app.component';

const MODULE_NAME = 'app';

export default angular
  .module(MODULE_NAME, [componentsModule])
  .component(MODULE_NAME, appComponent)
  .name;
