import Vue from 'vue';
import VueResource from 'vue-resource';
import App from './App';

Vue.use(VueResource);
Vue.http.options.root = `http://${location.hostname}:5100`;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App },
});
