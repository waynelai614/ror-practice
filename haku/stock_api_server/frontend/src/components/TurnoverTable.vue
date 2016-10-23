<template>
  <table class="mdl-data-table mdl-js-data-table">
    <thead>
      <tr>
        <th
          v-for="header in headers"
          @click="sortTurnovers(header.replace(/\s/g, '_').toLowerCase())"
        >{{ header }}</th>
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
      ascend: {},
    };
  },
  mounted() {
    this.$http.get('turnovers.json').then((res) => {
      this.update(res.data);
    });
  },
  methods: {
    sortTurnovers(sortCategory) {
      let category = sortCategory;
      switch (category) {
        case 'closing_of_yesterday':
          category = 'closing_ytd';
          break;
        case 'closing_of_today':
          category = 'closing_today';
          break;
        case 'trading_of_volume':
          category = 'trading_volume';
          break;
        default:
          break;
      }

      if (this.ascend[category] === undefined) {
        this.ascend[category] = true;
      }

      this.turnovers.sort((a, b) => (
        (this.ascend[category]) ? a[category] - b[category] : b[category] - a[category]
      ));
      this.ascend[category] = !this.ascend[category];
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
th {
  cursor: pointer;
}
</style>
