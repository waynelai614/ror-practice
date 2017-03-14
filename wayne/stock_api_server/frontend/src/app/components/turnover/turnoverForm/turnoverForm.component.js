class TurnoverFormComponent {
  constructor() {
    'ngInject'; // Not actually needed but best practice to keep here incase dependencies needed in the future
  }
  $onInit() {
    this.params = {
      codes: '',
      date: ''
    };
  }
  onSearch() {
    const { codes, date } = this.params;
    if (!codes && !date ) return;
    this.onGetByParams({
      $event: {
        params: {
          codes,
          date: date.replace(/-/g, '')
        }
      }
    });
  }
  onClear() {
    this.params = {
      codes: '',
      date: ''
    };
  }
}

export default {
  template: require('./turnoverForm.html'),
  controller: TurnoverFormComponent,
  bindings: {
    dates: '<',
    onGetByParams: '&'
  }
};
