<template>
  <div id="app">
    <date></date>
    <search-button></search-button>
    <turnover-table></turnover-table>
  </div>
</template>

<script>
import Date from './components/Date';
import TurnoverTable from './components/TurnoverTable';
import SearchButton from './components/SearchButton';

export default {
  name: 'app',
  components: {
    Date,
    TurnoverTable,
    SearchButton,
  },
};
</script>

<style>
</style>
