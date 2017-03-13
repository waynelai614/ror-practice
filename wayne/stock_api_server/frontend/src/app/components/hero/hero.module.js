import angular from 'angular';
import hero from './hero.component';

export default angular
  .module('components.hero', [])
  .component('hero', hero)
  .name;
