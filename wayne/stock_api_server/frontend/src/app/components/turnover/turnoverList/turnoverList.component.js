class TurnoverListComponent {
  constructor() {
    'ngInject'; // Not actually needed but best practice to keep here incase dependencies needed in the future
  }
  updateTableState(tableState) {
    this.onUpdateTableState({ tableState });
  }
  getAbsoluteValue(number) {
    return number == 0 ? number : Math.abs(number).toFixed(2);
  }
}

export default {
  template: require('./turnoverList.html'),
  controller: TurnoverListComponent,
  bindings: {
    // one-way bindings
    turnovers: '<',
    downloadUrl: '<',
    onUpdateTableState: '&'
  }
};
