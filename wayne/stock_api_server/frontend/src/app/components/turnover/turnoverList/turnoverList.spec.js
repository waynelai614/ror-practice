import turnoverList from './turnoverList.module';

const INITIAL_VALUES = {
  turnovers: [],
  download_url: './api/stock.xlsx'
};
const CHANGED_VALUES = {
  turnovers: [{
    'created_at': '2017-03-22T10:00:06+08:00',
    'id': 51,
    'stock_change': 2.4,
    'stock_closing_today': 31.0,
    'stock_closing_yesterday': 28.6,
    'stock_code': 2448,
    'stock_company_uri': 'http://stock.wearn.com/a2448.html',
    'stock_highest_price': 31.1,
    'stock_lowest_price': 29.65,
    'stock_name': '\u6676\u96fb',
    'stock_opening_price': 29.65,
    'stock_quote_change': 8.39,
    'stock_volume': 87567,
    'updated_at': '2017-03-22T10:00:06+08:00'
  }],
  download_url: './api/stock.xlsx?sort=stock_volume&direction=desc&codes=2448&date=20170322'
};

describe('Module: components.turnoverList', () => {

  describe('Component: turnoverList', () => {

    let parentScope;
    let element;
    let tbodyElement;
    let downloadButton;
    let ctrl;

    beforeEach(() => {
      angular.mock.module(turnoverList);

      angular.mock.inject(($compile, $rootScope, $componentController) => {
        parentScope = $rootScope.$new();
        parentScope.turnoversAttr = INITIAL_VALUES.turnovers;
        parentScope.downloadUrlAttr = INITIAL_VALUES.download_url;
        // assign a Jasmine spy to the parentScope field, to simulate a callback method.
        parentScope.updateTableState = jasmine.createSpy('updateTableState');

        ctrl = $componentController('turnoverList', null, { onUpdateTableState: parentScope.updateTableState });

        const template = `<turnover-list
        turnovers="turnoversAttr"
        download-url="downloadUrlAttr"
        on-update-table-state="updateTableState(tableState);"
        ></turnover-list>`;

        element = angular.element(template);
        $compile(element)(parentScope);

        parentScope.$digest();

        tbodyElement = angular.element(element[0].querySelector('.turnover-table > tbody'));
        downloadButton = angular.element(element[0].querySelector('.download-excel'));
      });
    });

    it('displays initial value', () => {
      expect(angular.element(tbodyElement[0].querySelector('tr')).length).toBe(INITIAL_VALUES.turnovers.length);
      expect(downloadButton.attr('href')).toBe(INITIAL_VALUES.download_url);
    });

    it('displays changed value', () => {
      parentScope.turnoversAttr = CHANGED_VALUES.turnovers;
      parentScope.downloadUrlAttr = CHANGED_VALUES.download_url;
      parentScope.$digest();
      expect(angular.element(tbodyElement[0].querySelector('tr')).length).toBe(CHANGED_VALUES.turnovers.length);
      expect(downloadButton.attr('href')).toBe(CHANGED_VALUES.download_url);
    });

    it('invokes updateTableState action', () => {
      ctrl.updateTableState();
      expect(parentScope.updateTableState).toHaveBeenCalled();
    });

    it('displays stock change number', () => {
      expect(ctrl.getAbsoluteValue(2.4)).toBe('2.40');
      expect(ctrl.getAbsoluteValue(-2.4)).toBe('2.40');
      expect(ctrl.getAbsoluteValue(0)).toBe(0);
    });

  });
});
