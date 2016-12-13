// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
var DOMSearch;
var DOMStockNumberInput;
var DOMStockTable;
var DOMStockNumberSelectWrapper;


function startSearching() {

  // send post request
  var stockNumberSelected = document.getElementsByClassName('stock_number_selected');
  if (stockNumberSelected ) {
    var result = Array.prototype.map.call(stockNumberSelected, function(p){
      var stockNumber = parseInt(p.innerHTML);
      return Number.isNaN(stockNumber) ? null : stockNumber  
    });

    result = result.filter(function(value) {
      return Number.isInteger(value)

    });

    // Send a POST request
    axios.post('/stock',{
      stock_number: result
    })
    .then(function (res){
      console.log(res)
      contentRendering(res.data)

      // 
      DOMSearch.className = 'button is-light is-outlined is-medium'
    })
    .catch(function() {
      
    });


  } else {


  }
}

function onSearchClick() {
  checkBeforeSearching();
}

function onStockNumberInputPressUp(event) {
  if (event.which == 13 || event.keyCode == 13) {
    checkBeforeSearching();
  }
}

function  checkBeforeSearching() {
  var value = DOMStockNumberInput.value;
  if ( DOMSearch.className.indexOf('is-disabled') < 0 ) {
    //code to execute here
    if (value.length > 0) {

      // append tags in wrapper 
      createStockSelectedTag(value);

      // epmty the textField
      DOMStockNumberInput.value ='';

    } else {

      // send post request
      startSearching();

      // clean tags
      DOMStockNumberSelectWrapper.innerHTML =''

      // diable btn
      DOMSearch.className += ' is-disabled'      
    }
  } else {
    console.log('cannot search')
  }
  
}

// rending the turnovers which was filtered by date and number 
function contentRendering(tableContent) {
  if (Array.isArray(tableContent)) {

    // epmty table content first
    DOMStockTable.innerHTML ='';

    
    

    tableContent.forEach(function(stock, index) {
      var tr = document.createElement('tr');
      var spanArray = Array.apply(null, new Array(2)).map(function () {
        return document.createElement('span');
      });
      var tdArray = Array.apply(null, new Array(12)).map(function() {
        return document.createElement('td');
      });
      var stockChangeClassName = stock.stock_change >= 0 ? 'stock_price_up' : 'stock_price_down';
      var stockChangeIcon = stock.stock_change >= 0 ? 'fa fa-arrow-up' : 'fa fa-arrow-down';
      // var tdArray = tdArray.fill(document.createElement('td'))

      tdArray[0].textContent = index + 1;

      // date
      var date = new Date(stock.timestamps) 
      tdArray[1].textContent = (date.getMonth() + 1) + ' / ' + date.getDate()

      tdArray[2].textContent = stock.stock_number
      tdArray[3].innerHTML = '<a href=' + stock.stock_company_hyperlink + '><font size="3">' + stock.stock_name + '</font></a>'
      tdArray[4].textContent = stock.stock_opening_price;
      tdArray[5].textContent = stock.stock_highest_price;
      tdArray[6].textContent = stock.stock_floor_price;
      tdArray[7].textContent = stock.stock_closing_yesterday;
      tdArray[8].textContent = stock.stock_closing_today;
      tdArray[9].textContent = parseInt(stock.stock_volumn).toLocaleString();

      // item 'change' 
      tdArray[10].className = stockChangeClassName; 
      spanArray[0].innerHTML = '<i class = \"' + stockChangeIcon +'\"></i>';
      spanArray[1].textContent = stock.stock_change;
      spanArray.forEach(function(span) {
        tdArray[10].appendChild(span);
      });

      tdArray[11].textContent = stock.stock_quote_change;

      // append dom 
      tdArray.forEach(function(td) {
        tr.appendChild(td);
      });
      DOMStockTable.appendChild(tr);


    });
  } else {

  }
  // empty the content 

}

// create the selected stock number tag
function createStockSelectedTag(value) {
  var span = document.createElement('span');
  var p = document.createElement('p');
  var button = document.createElement('button');

  span.className = 'tag is-info';
  p.className = 'stock_number_selected';
  p.innerHTML = value;
  button.className = 'delete is-small';

  span.appendChild(p);
  span.appendChild(button);
  DOMStockNumberSelectWrapper.appendChild(span);
}


// on DOM ready
document.addEventListener("DOMContentLoaded", function() {
  DOMSearch = document.getElementById('stock_search');
  DOMStockNumberInput = document.getElementById('stock_number_input');
  DOMStockNumberSelectWrapper = document.getElementById('stock_number_select_wrapper');
  DOMStockTable = document.getElementById('stock_table');

  // Search Btn 
  DOMSearch.onclick = onSearchClick;

  // DOMStockNumberInput
  DOMStockNumberInput.onkeyup = onStockNumberInputPressUp;


});



