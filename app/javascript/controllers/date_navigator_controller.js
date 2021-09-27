import { Controller } from "@hotwired/stimulus"
import * as d3 from "d3"

export default class extends Controller {
  static targets = [ "dateInput" ]

  get histogram() {
    const data = JSON.parse(this.data.get("histogramData"))
    data.forEach(function(d) {
      d.date = Date.parse(d.date);
    });
    return data;
  };

  handleChange(event) {
    this.emitNewDateEvent(new Date(event.target.value))
  }

  emitNewDateEvent(newDate) {
    const dateChangedEvent = new CustomEvent("datePicked",
      {
        detail: {
          newDate: newDate
        }
      }
    )
    window.dispatchEvent(dateChangedEvent)
  }

  connect() {
    const data = this.histogram;
    var margin = {
      top: 20,
      right: 80,
      bottom: 30,
      left: 50
    }
    var height = 80 - margin.top - margin.bottom;

    var y = d3.scaleSqrt()
      .exponent(0.1)
      .range([height, 0]);


    var svg = d3.create("svg")
      .attr("height", height + margin.top + margin.bottom)
      .attr("width", "100%");
    this.element.appendChild(svg.node());

    var width = svg.node().clientWidth - margin.left - margin.right;
    var x = d3.scaleUtc()
      .range([0, width]);
    var xAxis = d3.axisBottom(x)

    svg.append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var xExtent = d3.extent(data, function(d) {
      return d.date;
    });
    x.domain(
      [
        new Date(xExtent[0]).setDate(new Date(xExtent[0]).getDate()-5),
        new Date(xExtent[1]).setDate(new Date(xExtent[1]).getDate()+30)
      ]
    );

    y.domain([
      0,
      d3.max(data, function(d) {
        return d.value;
      })
    ]);

    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

    svg
      .selectAll("rect")
      .data(data)
      .enter()
      .append("rect")
      .attr("fill", "steelblue")
      .attr("height", d => height - y(d.value))
      .attr("width", 10)
      .attr("x", (d, i) => x(d.date))
      .attr("y", d => y(d.value))

    var chartCursor = svg.append("g")
      .attr("class", "mouse-over-effects");

    chartCursor.append("path") // this is the black vertical line to follow mouse
      .attr("class", "cursor-line")
      .style("stroke", "black")
      .style("stroke-width", "1px")
      .style("opacity", "0");

    let currentDate = new Date(this.dateInputTarget.value);

    let currentDateMarker = svg.append("path")
      .attr("class", "date-marker")
      .style("stroke", "red")
      .style("stroke-width", "1px")
      .style("opacity", "1")
      .attr("d", function() {
        var d = "M" + x(currentDate) + "," + height;
        d += " " + x(currentDate) + "," + 0;
        return d;
      });

    var lines = document.getElementsByClassName('line');

    var mousePerLine = chartCursor.selectAll('.mouse-per-line')
      .data(data)
      .enter()
      .append("g")
      .attr("class", "mouse-per-line");


    mousePerLine.append("text")
      .attr("transform", "translate(10,3)")
      .attr("class", "cursor-changes")
    mousePerLine.append("text")
      .attr("transform", "translate(10,13)")
      .attr("class", "cursor-date")

    const self = this;
    chartCursor.append('svg:rect') // append a rect to catch mouse movements on canvas
      .attr('width', width) // can't catch mouse events on a g element
      .attr('height', height)
      .attr('fill', 'none')
      .attr('pointer-events', 'all')
      .on('mouseout', function() { // on mouse out hide line, circles and text
        d3.select(".cursor-line")
          .style("opacity", "0");
        d3.selectAll(".mouse-per-line text")
          .style("opacity", "0");
      })
      .on('mouseover', function() { // on mouse in show line, circles and text
        d3.select(".cursor-line")
          .style("opacity", "1");
        d3.selectAll(".mouse-per-line text")
          .style("opacity", "1");
      })
      .on('click', function(event) { // on mouse in show line, circles and text
        var mouse = d3.pointer(event);
        var xDate = x.invert(mouse[0])

        d3.select(".date-marker")
          .attr("d", function() {
            var d = "M" + mouse[0] + "," + height;
            d += " " + mouse[0] + "," + 0;
            return d;
          });
        let newDate = xDate.toISOString().split('T')[0];
        self.dateInputTarget.value = newDate;
        self.emitNewDateEvent(newDate)
      })
      .on('mousemove', function(event) { // mouse moving over canvas
        var mouse = d3.pointer(event);
        d3.select(".cursor-line")
          .attr("d", function() {
            var d = "M" + mouse[0] + "," + height;
            d += " " + mouse[0] + "," + 0;
            return d;
          });

        d3.selectAll(".mouse-per-line")
          .attr("transform", function(d, i) {
            // d3.select(this).select('text.cursor-changes')
            //   .text(y.invert(11).toFixed(0) + " changes")
            d3.select(this).select('text.cursor-date')
              .text(x.invert(mouse[0]).toISOString().split('T')[0])

            return "translate(" + mouse[0] + ",0)";
          });
      });
  }
}
