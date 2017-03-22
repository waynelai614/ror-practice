import hero from './hero.module';

const INITIAL_VALUE = 'https://0.0.0.0:3000';
const CHANGED_VALUE = 'https://127.0.0.1:3001';

describe('Module: components.hero', () => {

  describe('Component: hero', () => {

    let parentScope;
    let element;

    beforeEach(() => {
      angular.mock.module(hero);

      // inject $compile and $rootScope Angular services.
      // We need them to render our tested component and to simulate its parent component.
      angular.mock.inject(($compile, $rootScope) => {
        // simulate the scope of the parent component and set some fields on this scope.
        parentScope = $rootScope.$new();
        parentScope.linkAttr = INITIAL_VALUE;

        // compile our tested component with the parentScope
        element = angular.element('<hero link="linkAttr"></hero>');
        $compile(element)(parentScope);

        // initiate the Angular’s digest loop to make our changes visible.
        // ex: '{{$ctrl.link}}' => 'https://0.0.0.0:3000'
        parentScope.$digest();
      });
    });

    it('displays initial value of link attr', () => {
      const linkValue = angular.element(element[0].querySelector('.data-source-link')).attr('ng-href');
      expect(linkValue).toBe(INITIAL_VALUE);
    });

    it('displays changed value of link attr', () => {
      parentScope.linkAttr = CHANGED_VALUE;
      parentScope.$digest();
      const linkValue = angular.element(element[0].querySelector('.data-source-link')).attr('ng-href');
      expect(linkValue).toBe(CHANGED_VALUE);
    });
  });
});
