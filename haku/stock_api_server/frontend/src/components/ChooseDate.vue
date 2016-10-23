<template>
  <input type="date" name="date" v-model="date">
</template>

<script>
export default {
  name: 'choose-date',
  data() {
    const today = new Date();
    return {
      date: `${(today.getYear() + 1900)}-${(today.getMonth() + 1)}-${today.getDate()}`,
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
