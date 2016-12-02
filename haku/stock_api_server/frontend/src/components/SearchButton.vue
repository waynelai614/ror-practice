<template>
  <button
    class="mdl-button mdl-js-button mdl-js-ripple-effect"
    @click="searchTurnovers"
  >{{text}}</button>
</template>

<script>
export default {
  name: 'search-button',
  props: {
    search: {
      type: Function,
      required: true,
    },
    text: {
      type: String,
      default() { return 'Search turnovers on this date'; },
    },
  },
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
