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
    let searchButton;
    let clearButton;

    beforeEach(() => {
      angular.mock.module(turnoverForm);

      angular.mock.inject(($compile, $rootScope) => {
        parentScope = $rootScope.$new();
        parentScope.datesAttr = INITIAL_DATES_VALUE;
        // assign a Jasmine spy to the parentScope field, to simulate a callback method.
        parentScope.getByParams = jasmine.createSpy('getByParams');

        const template = `<turnover-form
          dates="datesAttr"
          on-get-by-params="getByParams($event);"
        >
        </turnover-form>`;
        element = angular.element(template);
        $compile(element)(parentScope);

        parentScope.$digest();

        // get elements
        stockCodeInput = angular.element(element[0].querySelector('.stock-codes'));
        dateSelect = angular.element(element[0].querySelector('.stock-date'));
        searchButton = angular.element(element[0].querySelector('.search-button'));
        clearButton = angular.element(element[0].querySelector('.clear-button'));
      });
    });

    it('displays initial value of dates attr', () => {
      const optionLength = dateSelect[0].querySelectorAll('option[ng-repeat]').length;
      expect(optionLength).toBe(INITIAL_DATES_VALUE.length);
    });

    it('displays changed value of dates attr', () => {
      parentScope.datesAttr = CHANGED_DATES_VALUE;
      parentScope.$digest();
      const optionLength = dateSelect[0].querySelectorAll('option[ng-repeat]').length;
      expect(optionLength).toBe(CHANGED_DATES_VALUE.length);
    });

    it('invokes search action without params', () => {
      searchButton.triggerHandler('click');
      // check if the spy was called with the correct parameter
      expect(parentScope.getByParams).not.toHaveBeenCalled();
    });

    it('invokes search action with params', () => {
      // set value and trigger event
      stockCodeInput
        .val(TEST_VALUE)
        .triggerHandler('change');
      dateSelect
        .val(INITIAL_DATES_VALUE[0])
        .triggerHandler('change');

      searchButton.triggerHandler('click');

      expect(parentScope.getByParams).toHaveBeenCalledWith({
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

      clearButton.triggerHandler('click');

      expect(stockCodeInput.val()).toBe('');
      expect(dateSelect.val()).toBe('');
    });

  });
});
