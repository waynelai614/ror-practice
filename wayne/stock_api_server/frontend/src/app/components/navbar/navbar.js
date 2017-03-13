import './nabvar.css';

const navbar = {
  template: require('./navbar.html'),
  bindings: {
    // one-way bindings
    link: '<'
  }
};

export default navbar;
