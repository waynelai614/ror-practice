import _ from 'lodash/core';
import app from './app';
import { defaultState } from './app.component';

describe('app', () => {

  describe('app.component', () => {
    let ctrl;

    beforeEach(() => {
      angular.mock.module(app);

      angular.mock.inject(($componentController) => {
        ctrl = $componentController('app');
        ctrl.$onInit();
      });
    });

    it('should contain the default state', () => {
      expect(_.isEqual(ctrl.state, defaultState)).toBe(true);
    });
  });
});
