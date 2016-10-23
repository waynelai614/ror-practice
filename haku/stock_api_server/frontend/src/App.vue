<template>
  <div id="app">
    <choose-date ref="chooseDate"></choose-date>
    <search-button :search="getDataFromDate"></search-button>
    <turnover-table :turnovers="turnovers" :update="updateTurnovers"></turnover-table>
  </div>
</template>

<script>
import ChooseDate from './components/ChooseDate';
import TurnoverTable from './components/TurnoverTable';
import SearchButton from './components/SearchButton';

export default {
  name: 'app',
  components: {
    ChooseDate,
    TurnoverTable,
    SearchButton,
  },
  data() {
    return {
      turnovers: [],
    };
  },
  methods: {
    updateTurnovers(turnovers) {
      this.turnovers = turnovers;
    },
    getDataFromDate() {
      this.$http.get('turnovers.json', {
        params: {
          date: this.$refs.chooseDate.date,
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
