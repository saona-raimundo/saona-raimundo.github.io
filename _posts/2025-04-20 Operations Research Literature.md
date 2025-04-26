---

layout: post
title:  "Operations Research Literature"
date:   2025-04-20 00:00:00 +0000
front:  false

---

In preparation to my new job in Operations Research, here is a collection of literature of the area I find interesting.

<style>
.sr-only {
  position: absolute;
  top: -30em;
}

table.sortable td,
table.sortable th {
  padding: 0.125em 0.25em;
  width: 8em;
}

table.sortable th {
  font-weight: bold;
  border-bottom: thin solid #888;
  position: relative;
}

table.sortable th.no-sort {
  padding-top: 0.35em;
}

table.sortable th:nth-child(5) {
  width: 10em;
}

table.sortable th button {
  padding: 4px;
  margin: 1px;
  font-size: 100%;
  font-weight: bold;
  background: transparent;
  border: none;
  display: inline;
  right: 0;
  left: 0;
  top: 0;
  bottom: 0;
  width: 100%;
  text-align: left;
  outline: none;
  cursor: pointer;
}

table.sortable th button span {
  position: absolute;
  right: 4px;
}

table.sortable th[aria-sort="descending"] span::after {
  content: "▼";
  color: currentcolor;
  font-size: 100%;
  top: 0;
}

table.sortable th[aria-sort="ascending"] span::after {
  content: "▲";
  color: currentcolor;
  font-size: 100%;
  top: 0;
}

table.show-unsorted-icon th:not([aria-sort]) button span::after {
  content: "♢";
  color: currentcolor;
  font-size: 100%;
  position: relative;
  top: -3px;
  left: -4px;
}

table.sortable td.num {
  text-align: right;
}

table.sortable tbody tr:nth-child(odd) {
  background-color: #ddd;
}

/* Focus and hover styling */

table.sortable th button:focus,
table.sortable th button:hover {
  padding: 2px;
  border: 2px solid currentcolor;
  background-color: #e5f4ff;
}

table.sortable th button:focus span,
table.sortable th button:hover span {
  right: 2px;
}

table.sortable th:not([aria-sort]) button:focus span::after,
table.sortable th:not([aria-sort]) button:hover span::after {
  content: "▼";
  color: currentcolor;
  font-size: 100%;
  top: 0;
}
</style>

<script>
/*
 *   This content is licensed according to the W3C Software License at
 *   https://www.w3.org/Consortium/Legal/2015/copyright-software-and-document
 *
 *   File:   sortable-table.js
 *
 *   Desc:   Adds sorting to a HTML data table that implements ARIA Authoring Practices
 */

'use strict';

class SortableTable {
  constructor(tableNode) {
    this.tableNode = tableNode;

    this.columnHeaders = tableNode.querySelectorAll('thead th');

    this.sortColumns = [];

    for (var i = 0; i < this.columnHeaders.length; i++) {
      var ch = this.columnHeaders[i];
      var buttonNode = ch.querySelector('button');
      if (buttonNode) {
        this.sortColumns.push(i);
        buttonNode.setAttribute('data-column-index', i);
        buttonNode.addEventListener('click', this.handleClick.bind(this));
      }
    }

    this.optionCheckbox = document.querySelector(
      'input[type="checkbox"][value="show-unsorted-icon"]'
    );

    if (this.optionCheckbox) {
      this.optionCheckbox.addEventListener(
        'change',
        this.handleOptionChange.bind(this)
      );
      if (this.optionCheckbox.checked) {
        this.tableNode.classList.add('show-unsorted-icon');
      }
    }
  }

  setColumnHeaderSort(columnIndex) {
    if (typeof columnIndex === 'string') {
      columnIndex = parseInt(columnIndex);
    }

    for (var i = 0; i < this.columnHeaders.length; i++) {
      var ch = this.columnHeaders[i];
      var buttonNode = ch.querySelector('button');
      if (i === columnIndex) {
        var value = ch.getAttribute('aria-sort');
        if (value === 'descending') {
          ch.setAttribute('aria-sort', 'ascending');
          this.sortColumn(
            columnIndex,
            'ascending',
            ch.classList.contains('num')
          );
        } else {
          ch.setAttribute('aria-sort', 'descending');
          this.sortColumn(
            columnIndex,
            'descending',
            ch.classList.contains('num')
          );
        }
      } else {
        if (ch.hasAttribute('aria-sort') && buttonNode) {
          ch.removeAttribute('aria-sort');
        }
      }
    }
  }

  sortColumn(columnIndex, sortValue, isNumber) {
    function compareValues(a, b) {
      if (sortValue === 'ascending') {
        if (a.value === b.value) {
          return 0;
        } else {
          if (isNumber) {
            return a.value - b.value;
          } else {
            return a.value < b.value ? -1 : 1;
          }
        }
      } else {
        if (a.value === b.value) {
          return 0;
        } else {
          if (isNumber) {
            return b.value - a.value;
          } else {
            return a.value > b.value ? -1 : 1;
          }
        }
      }
    }

    if (typeof isNumber !== 'boolean') {
      isNumber = false;
    }

    var tbodyNode = this.tableNode.querySelector('tbody');
    var rowNodes = [];
    var dataCells = [];

    var rowNode = tbodyNode.firstElementChild;

    var index = 0;
    while (rowNode) {
      rowNodes.push(rowNode);
      var rowCells = rowNode.querySelectorAll('th, td');
      var dataCell = rowCells[columnIndex];

      var data = {};
      data.index = index;
      data.value = dataCell.textContent.toLowerCase().trim();
      if (isNumber) {
        data.value = parseFloat(data.value);
      }
      dataCells.push(data);
      rowNode = rowNode.nextElementSibling;
      index += 1;
    }

    dataCells.sort(compareValues);

    // remove rows
    while (tbodyNode.firstChild) {
      tbodyNode.removeChild(tbodyNode.lastChild);
    }

    // add sorted rows
    for (var i = 0; i < dataCells.length; i += 1) {
      tbodyNode.appendChild(rowNodes[dataCells[i].index]);
    }
  }

  /* EVENT HANDLERS */

  handleClick(event) {
    var tgt = event.currentTarget;
    this.setColumnHeaderSort(tgt.getAttribute('data-column-index'));
  }

  handleOptionChange(event) {
    var tgt = event.currentTarget;

    if (tgt.checked) {
      this.tableNode.classList.add('show-unsorted-icon');
    } else {
      this.tableNode.classList.remove('show-unsorted-icon');
    }
  }
}

// Initialize sortable table buttons
window.addEventListener('load', function () {
  var sortableTables = document.querySelectorAll('table.sortable');
  for (var i = 0; i < sortableTables.length; i++) {
    new SortableTable(sortableTables[i]);
  }
});
</script>

<table class="searchable sortable">
 <thead>
   <tr>
     <th></th>
     <th></th>
     <th></th>
  </tr>
 </thead>

<div class="table-wrap"><table class="sortable">
  <caption>
    Interesting books
  </caption>
  <thead>
    <tr>
      <th aria-sort="descending">
        <button>
          Title
          <span aria-hidden="true"></span>
        </button>
      </th>
      <th>
        <button>
          Year
          <span aria-hidden="true"></span>
        </button>
      </th>
      <th>
        <button>
          Topic
          <span aria-hidden="true"></span>
        </button>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="https://link.springer.com/book/10.1007/978-3-031-30324-1">Basic Mathematical Programming Theory</a></td>
      <td>2023</td>
      <td>Mathematical Programming</td>
    </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-030-97626-2">Building and Solving Mathematical Programming Models</a></td>
    <td>2022</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-031-61261-9">An Introduction to Robust Combinatorial Optimization</a></td>
    <td>2024</td>
    <td>Optimization</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-981-99-5491-9">Optimization Essentials</a></td>
    <td>2024</td>
    <td>Optimization</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-031-40180-0">Markov Decision Processes and Stochastic Positional Games</a></td>
    <td>2024</td>
    <td>Dynamic Modelling</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/9783031886379">The Unaffordable Price of Static Decision-making Models</a></td>
    <td>2025</td>
    <td>Dynamic Modelling</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/b106473">Modeling Uncertainty </a></td>
    <td>2002</td>
    <td>Uncertainty modelling</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-030-19107-8">Games in Management Science</a></td>
    <td>2020</td>
    <td>Game Theory</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-030-39415-8">Linear Programming</a></td>
    <td>2020</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-030-57250-1">Modelling in Mathematical Programming</a></td>
    <td>2021</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-030-85450-8">Linear and Nonlinear Programming </a></td>
    <td>2021</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-030-86194-0">Foundations and Methods of Stochastic Simulation</a></td>
    <td>2021</td>
    <td>Simulation</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-319-91086-4">Handbook of Metaheuristics</a></td>
    <td>2019</td>
    <td>Heuristics</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-319-52259-3">Sensitivity Analysis</a></td>
    <td>2017</td>
    <td>Sensitivity Analysis</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4939-7055-1"> Linear and Nonlinear Optimization </a></td>
    <td>2017</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4939-1007-6">Case Studies in Operations Research</a></td>
    <td>2015</td>
    <td>Applications</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4614-9050-0">Two-Person Zero-Sum Games</a></td>
    <td>2014</td>
    <td>Game Theory</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4419-6491-5">Linear Programming and Generalizations</a></td>
    <td>2011</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4615-4381-7">Handbook of Semidefinite Programming</a></td>
    <td>2000</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-319-18842-3">Linear and Nonlinear Programming</a></td>
    <td>2016</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-3-319-11836-9">Socially Responsible Investment</a></td>
    <td>2015</td>
    <td>Portfolio Theory</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4614-7630-6">Linear Programming</a></td>
    <td>2014</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4419-7729-8">Stochastic Linear Programming</a></td>
    <td>2011</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4419-5771-9">Practical Goal Programming</a></td>
    <td>2010</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4419-1665-5">Handbook of Metaheuristics</a></td>
    <td>2010</td>
    <td>Heuristics</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-0-387-74676-0">Computational Probability</a></td>
    <td>2008</td>
    <td>Simulation</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-0-387-74503-9">Linear and Nonlinear Programming</a></td>
    <td>2008</td>
    <td>Mathematical Programming</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-0-387-73699-0">Building Intuition</a></td>
    <td>2008</td>
    <td>Basics</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4615-0805-2">Handbook of Markov Decision Processes</a></td>
    <td>2002</td>
    <td>Dynamic Modelling</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/b109681">Game Theory and Business Applications</a></td>
    <td>2001</td>
    <td>Game Theory</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-981-99-4833-8">Game Theory with Applications in Operations Management</a></td>
    <td>2024</td>
    <td>Game Theory</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4614-7095-3">Game Theory and Business Applications </a></td>
    <td>2014</td>
    <td>Game Theory</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4615-5501-8">Operations Research in the Airline Industry</a></td>
    <td>1198</td>
    <td>Applications</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4615-6103-3">Advances in Sensitivity Analysis and Parametric Programming</a></td>
    <td>1997</td>
    <td>Sensitivity Analysis</td>
   </tr>
   <tr>
    <td><a href="https://link.springer.com/book/10.1007/978-1-4615-6205-4">Foundations of Queueing Theory</a></td>
    <td>1997</td>
    <td>Queueing Theory</td>
   </tr>
  </tbody>
</table></div>


## Sources

- [International Series in Operations Research & Management Science](https://www.springer.com/series/6161)
