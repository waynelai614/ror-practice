import angular from 'angular';

import navbar from './navbar/navbar.module';
import hero from './hero/hero.module';
import turnovers from './turnovers/turnovers.module';

export default angular
  .module('components', [
    navbar,
    hero,
    turnovers
  ])
  .name;
