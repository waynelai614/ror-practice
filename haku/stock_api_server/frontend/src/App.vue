<template>
  <div id="app">
    <mdl-datepicker v-model="date"></mdl-datepicker>
    <search-button :search="getDataFromDate"></search-button>
    <input type="text" name="code" v-model="code">
    <search-button :search="getDataFromCode"></search-button>
    <turnover-table :turnovers="turnovers" :update="updateTurnovers"></turnover-table>
  </div>
</template>

<script>
import 'vue-mdl-datepicker/dist/vue-mdl-datepicker.css';
import MdlDatepicker from 'vue-mdl-datepicker';
import TurnoverTable from './components/TurnoverTable';
import SearchButton from './components/SearchButton';

export default {
  name: 'app',
  components: {
    MdlDatepicker,
    TurnoverTable,
    SearchButton,
  },
  data() {
    return {
      turnovers: [],
      date: new Date(),
      code: null,
    };
  },
  methods: {
    updateTurnovers(turnovers) {
      this.turnovers = turnovers;
    },
    getDataFromDate() {
      const date = `${(this.date.getFullYear())}-${(this.date.getMonth() + 1)}-${this.date.getDate()}`;
      this.$http.get('turnovers.json', {
        params: {
          date,
        },
      }).then((res) => {
        this.updateTurnovers(res.data);
      });
    },
    getDataFromCode() {
      this.$http.get('turnovers.json', {
        params: {
          code: this.code,
        },
      }).then((res) => {
        this.updateTurnovers(res.data);
      });
    },
  },
};
</script>

<style>
</style>
