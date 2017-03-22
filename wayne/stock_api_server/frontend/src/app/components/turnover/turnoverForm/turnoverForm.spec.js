import turnoverForm from './turnoverForm.module';

const TEST_VALUE = '2344';
const INITIAL_DATES_VALUE = ['2017-03-21'];
const CHANGED_DATES_VALUE = ['2017-03-22', ...INITIAL_DATES_VALUE];

describe('Module: components.turnoverForm', () => {

  describe('Component: turnoverForm', () => {

    let parentScope;
    let element;
    let stockCodeInput;
    let dateSelect;

    beforeEach(() => {
      angular.mock.module(turnoverForm);

      angular.mock.inject(($compile, $rootScope) => {
        parentScope = $rootScope.$new();
        parentScope.datesAttr = INITIAL_DATES_VALUE;
        // assign a Jasmine spy to the parentScope field, to simulate a callback method.
        parentScope.onGetByParams = jasmine.createSpy('onGetByParams');

        const template = `<turnover-form
          dates="datesAttr"
          on-get-by-params="onGetByParams($event);"
        >
        </turnover-form>`;
        element = angular.element(template);
        $compile(element)(parentScope);

        parentScope.$digest();

        // get stock codes input & date select
        stockCodeInput = angular.element(element[0].querySelector('.stock-codes'));
        dateSelect = angular.element(element[0].querySelector('.stock-date'));
      });
    });

    it('displays initial value of dates attr', () => {
      const optionLength = element[0].querySelectorAll('select > option[ng-repeat]').length;
      expect(optionLength).toBe(INITIAL_DATES_VALUE.length);
    });

    it('displays changed value of dates attr', () => {
      parentScope.datesAttr = CHANGED_DATES_VALUE;
      parentScope.$digest();
      const optionLength = element[0].querySelectorAll('select > option[ng-repeat]').length;
      expect(optionLength).toBe(CHANGED_DATES_VALUE.length);
    });

    it('invokes search action without params', () => {
      // get button element and trigger click event
      const searchButton = angular.element(element[0].querySelector('.search-button'));
      searchButton.triggerHandler('click');

      // check if the spy was called with the correct parameter
      expect(parentScope.onGetByParams).not.toHaveBeenCalled();
    });

    it('invokes search action with params', () => {
      // set value and trigger event
      stockCodeInput
        .val(TEST_VALUE)
        .triggerHandler('change');
      dateSelect
        .val(INITIAL_DATES_VALUE[0])
        .triggerHandler('change');

      const searchButton = angular.element(element[0].querySelector('.search-button'));
      searchButton.triggerHandler('click');

      expect(parentScope.onGetByParams).toHaveBeenCalledWith({
        params: {
          codes: TEST_VALUE,
          date: INITIAL_DATES_VALUE[0].replace(/-/g, '')
        }
      });
    });

    it('invokes clear action', () => {
      // set value and trigger event
      stockCodeInput
        .val(TEST_VALUE)
        .triggerHandler('change');
      dateSelect
        .val(INITIAL_DATES_VALUE[0])
        .triggerHandler('change');

      const clearButton = angular.element(element[0].querySelector('.clear-button'));
      clearButton.triggerHandler('click');

      expect(stockCodeInput.val()).toBe('');
      expect(dateSelect.val()).toBe('');
    });

  });
});
