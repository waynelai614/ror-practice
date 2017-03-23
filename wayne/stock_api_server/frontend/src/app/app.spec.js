import _ from 'lodash/core';
import app from './app';
import { API_HOST } from 'config';
import { defaultState } from './app.component';

describe('app', () => {

  describe('app.component', () => {

    let ctrl;
    let $httpBackend;

    let parentScope;
    let element;

    beforeEach(() => {
      angular.mock.module(app);

      angular.mock.inject(($componentController, _$httpBackend_) => {
        ctrl = $componentController('app');
        ctrl.$onInit();
        $httpBackend = _$httpBackend_;
      });

      angular.mock.inject(($compile, $rootScope) => {
        parentScope = $rootScope.$new();
        element = angular.element('<app>Loading...</app>');
        $compile(element)(parentScope);
      });
    });

    it('should fetch datas on init and expect (200 status)', () => {
      const avaliable_date = ['20170323', '20170322'];
      const turnovers = [{stock_code: '9527'}, {stock_code: '9453'}];

      $httpBackend
        .when('GET', `${API_HOST}/api/stock/date`)
        .respond(200, avaliable_date);

      $httpBackend
        .when('GET', `${API_HOST}/api/stock.json`)
        .respond(200, turnovers);

      $httpBackend.flush();

      const newState = _.assignIn({}, defaultState, { turnovers, avaliable_date });
      expect(_.isEqual(ctrl.state, newState)).toBe(true);
    });

    it('invokes updateTableState action', () => {
      const tableState = {
        sort: {
          predicate: 'stock_code',
          reverse: false
        }
      };
      ctrl.updateTableState(tableState);
      const newState = _.assignIn({}, defaultState, { table: tableState });
      expect(_.isEqual(ctrl.state.table, newState.table)).toBe(true);
    });

    it('invokes updateDownloadLink action', () => {
      const defaultDownloadLink = defaultState.link.download_url;
      ctrl.state.searchTerm = {
        codes: '9453',
        date: '20170323'
      };
      ctrl.state.table.sort = {
        predicate: 'stock_change',
        reverse: false
      };
      ctrl.updateDownloadLink();
      expect(defaultDownloadLink).not.toBe(ctrl.state.link.download_url);
    });

    it('displays notification when http error', () => {
      $httpBackend
        .when('GET', `${API_HOST}/api/stock/date`)
        .respond(404, {});

      $httpBackend
        .when('GET', `${API_HOST}/api/stock.json`)
        .respond(500, {});
      $httpBackend.flush();
      parentScope.$digest();

      let notificationElement = angular.element(element[0].querySelector('.error-message'));
      expect(notificationElement.length).toBe(1);
    });

    it('invokes closeErrorMessage action', () => {
      // show error-message div
      $httpBackend
        .when('GET', `${API_HOST}/api/stock/date`)
        .respond(404, {});

      $httpBackend
        .when('GET', `${API_HOST}/api/stock.json`)
        .respond(500, {});
      $httpBackend.flush();
      parentScope.$digest();

      let sectionElement = angular.element(element[0].querySelector('.section'));
      let deleteButton = angular.element(sectionElement[0].querySelector('.delete'));

      expect(angular.element(sectionElement[0].querySelector('.error-message')).length).toBe(1);
      // after click the deleteButton, errorMessage will disappear
      deleteButton.triggerHandler('click');
      expect(angular.element(sectionElement[0].querySelector('.error-message')).length).toBe(0);
    });

  });
});
