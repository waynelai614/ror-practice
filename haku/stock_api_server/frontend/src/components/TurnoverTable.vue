<template>
  <table>
    <thead>
      <tr>
        <th>Stock Code</th>
        <th>Stock Name</th>
        <th>Opening Price</th>
        <th>Highest Price</th>
        <th>Lowest Price</th>
        <th>Closing of Yesterday</th>
        <th>Closing of Today</th>
        <th>Trading of Volume</th>
        <th>Change</th>
        <th>Change Limit</th>
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
  data() {
    return {
      turnovers: [],
    };
  },
  mounted() {
    this.$http.get('turnovers.json').then((res) => {
      this.turnovers = res.data;
    });
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
