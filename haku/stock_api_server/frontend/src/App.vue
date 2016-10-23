<template>
  <div id="app">
    <choose-date ref="chooseDate"></choose-date>
    <search-button></search-button>
    <turnover-table></turnover-table>
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
};
</script>

<style>
</style>
