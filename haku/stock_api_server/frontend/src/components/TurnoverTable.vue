<template>
  <table class="mdl-data-table mdl-js-data-table">
    <thead>
      <tr>
        <th v-for="header in headers">{{ header }}</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="turnover in turnovers">
        <td>{{ turnover.stock_code }}</td>
        <td>{{ turnover.stock_name }}</td>
        <td>{{ turnover.opening_price }}</td>
        <td>{{ turnover.highest_price }}</td>
        <td>{{ turnover.lowest_price }}</td>
        <td>{{ turnover.closing_ytd }}</td>
        <td>{{ turnover.closing_today }}</td>
        <td>{{ turnover.trading_volume }}</td>
        <td>{{ turnover.change }}</td>
        <td>{{ turnover.change_limit }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
export default {
  name: 'turnover-table',
  props: ['turnovers', 'update'],
  data() {
    return {
      headers: [
        'Stock Code',
        'Stock Name',
        'Opening Price',
        'Highest Price',
        'Lowest Price',
        'Closing of Yesterday',
        'Closing of Today',
        'Trading of Volume',
        'Change',
        'Change Limit',
      ],
    };
  },
  mounted() {
    this.$http.get('turnovers.json').then((res) => {
      this.update(res.data);
    });
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
