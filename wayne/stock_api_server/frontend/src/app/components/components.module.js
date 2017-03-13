import angular from 'angular';

import navbar from './navbar/navbar.module';
import hero from './hero/hero.module';
import turnover from './turnover/turnover.module';

export default angular
  .module('components', [
    navbar,
    hero,
    turnover
  ])
  .name;
