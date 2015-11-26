var popupNav = document.getElementById('menu').cloneNode(true);
popupNav.setAttribute('id', 'popupNav');
popupNav.setAttribute('class', 'displayNone');
document.body.appendChild(popupNav);

var menuButton = document.createElement('a');
menuButton.setAttribute('class', 'menuButton');
menuButton.addEventListener('click', function(){
    if (popupNav.getAttribute('class') === 'displayNone') {
        popupNav.removeAttribute('class');
    } else {
        popupNav.setAttribute('class', 'displayNone');
    }
});
document.body.appendChild(menuButton);
