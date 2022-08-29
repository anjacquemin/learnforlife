function myLoop(itself, themeCount) {
  setTimeout(function() {
    const rotate = parseInt(eval(`itself.circleDiv${theme_index}Target.dataset.rotate${theme_index}`));
    const targets = eval(`itself.circle${theme_index}Targets`)
    targets.forEach(circle => circle.style.transform = `rotate(${(rotate)}deg)`)
    theme_index++;
    if (theme_index < themeCount-1) {
      myLoop(itself, themeCount);
    }
  }, 200)
}

export { myLoop }
