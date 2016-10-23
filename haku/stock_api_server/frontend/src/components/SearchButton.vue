<template>
  <button
    class="mdl-button mdl-js-button mdl-js-ripple-effect"
    @click="searchTurnovers"
  >Search turnovers on this date</button>
</template>

<script>
export default {
  name: 'search-button',
  props: ['search'],
  methods: {
    searchTurnovers() {
      this.search();
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
