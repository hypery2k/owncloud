function addFixture(html) {
  document.body.innerHTML = __html__['fixtures/' + html];
}

function clearMyFixtures() {
  document.body.innerHTML = '';
}