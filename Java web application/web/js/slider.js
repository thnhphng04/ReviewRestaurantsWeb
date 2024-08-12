function updateSliderBackground(slider, demo) {
    var value = (slider.value - slider.min) / (slider.max - slider.min) * 100;
    slider.style.background = 'linear-gradient(to right, #9c1628 ' + value + '%, #ddd ' + value + '%)';
    demo.innerHTML = slider.value;
}

function updateOverallRating() {
    var total = 0;
    
    for (var i = 0; i < 5; i++) {
        total += parseFloat(sliders[i].slider.value);
    }
    var average = (total / 5).toFixed(1);
    document.getElementById("rating").value = average;
}

var sliders = [
    {slider: document.getElementById("myRange1"), demo: document.getElementById("demo1")},
    {slider: document.getElementById("myRange2"), demo: document.getElementById("demo2")},
    {slider: document.getElementById("myRange3"), demo: document.getElementById("demo3")},
    {slider: document.getElementById("myRange4"), demo: document.getElementById("demo4")},
    {slider: document.getElementById("myRange5"), demo: document.getElementById("demo5")},
    {slider: document.getElementById("myRange6"), demo: document.getElementById("demo6")},
    {slider: document.getElementById("myRange7"), demo: document.getElementById("demo7")},
    {slider: document.getElementById("myRange8"), demo: document.getElementById("demo8")},
    {slider: document.getElementById("myRange9"), demo: document.getElementById("demo9")},
    {slider: document.getElementById("myRange10"), demo: document.getElementById("demo10")}
];

sliders.forEach(function (item) {
    updateSliderBackground(item.slider, item.demo);
    item.slider.oninput = function () {
        updateSliderBackground(item.slider, item.demo);
        updateOverallRating();
    }
});

// Initialize the overall rating on page load
updateOverallRating();