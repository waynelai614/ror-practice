import navbar from './navbar.module';

const INITIAL_VALUE = 'https://github.com/waynelai614';
const CHANGED_VALUE = 'https://github.com/rakuten-f2e/ror-practice/tree/dev/wayne/wayne/stock_api_server';

describe('Module: components.navbar', () => {

  describe('Component: navbar', () => {

    let parentScope;
    let element;

    beforeEach(() => {
      angular.mock.module(navbar);

      angular.mock.inject(($compile, $rootScope) => {
        parentScope = $rootScope.$new();
        parentScope.linkAttr = INITIAL_VALUE;

        element = angular.element('<navbar link="linkAttr"></navbar>');
        $compile(element)(parentScope);

        parentScope.$digest();
      });
    });

    it('displays initial value of link attr', () => {
      const linkValue = angular.element(element[0].querySelector('.github-link')).attr('ng-href');
      expect(linkValue).toBe(INITIAL_VALUE);
    });

    it('displays changed value of link attr', () => {
      parentScope.linkAttr = CHANGED_VALUE;
      parentScope.$digest();
      const linkValue = angular.element(element[0].querySelector('.github-link')).attr('ng-href');
      expect(linkValue).toBe(CHANGED_VALUE);
    });
  });
});
