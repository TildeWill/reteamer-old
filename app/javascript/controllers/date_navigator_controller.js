import { Controller } from "@hotwired/stimulus"
import * as d3 from "d3"

export default class extends Controller {
  static targets = [ "dateInput" ]

  get histogram() {
    this.histogramData = JSON.parse(this.data.get("histogramData"))
    this.histogramData.forEach(function(d) {
      d.date = Date.parse(d.date);
    });
    return this.histogramData;
  };

  handleNewOrgData(event) {
    // console.log("=============>", event.detail.orgData.histogram);
    this.histogramData = event.detail.orgData.histogram
    this.histogramData.forEach(function(d) {
      d.date = Date.parse(d.date);
    });
    this.renderChart()
  }
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
    const self = this;
    this.margin = {
      top: 20,
      right: 80,
      bottom: 30,
      left: 50
    }
    this.height = 80 - this.margin.top - this.margin.bottom;
    this.y = d3.scaleSqrt()
      .exponent(0.1)
      .range([this.height, 0]);

    this.svg = d3.create("svg")
      .attr("height", this.height + this.margin.top + this.margin.bottom)
      .attr("width", "100%");
    this.svg.append("g") //TODO: is this needed?
      .attr("transform", "translate(" + this.margin.left + "," + this.margin.top + ")");
    this.element.appendChild(this.svg.node()); //must do this before we can read the width of the node

    this.width = this.svg.node().clientWidth - this.margin.left - this.margin.right;
    this.x = d3.scaleUtc().range([0, this.width]);
    this.xAxis = d3.axisBottom(this.x)

    this.currentDate = new Date(self.dateInputTarget.value);

    let currentDateMarker = self.svg.append("path")
      .attr("class", "date-marker")
      .style("stroke", "red")
      .style("stroke-width", "1px")
      .style("opacity", "1")
      .attr("d", function() {
        var d = "M" + self.x(self.currentDate) + "," + self.height;
        d += " " + self.x(self.currentDate) + "," + 0;
        return d;
      });

    this.chartCursor = this.svg.append("g")
      .attr("class", "mouse-over-effects");

    this.chartCursor.append("path") // this is the black vertical line to follow mouse
      .attr("class", "cursor-line")
      .style("stroke", "black")
      .style("stroke-width", "1px")
      .style("opacity", "0");

    self.xAxisElement = self.svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + self.height + ")")

    self.mouseLine = self.svg.append("g")
      .attr("class", "mouse-per-line");

    self.mouseLine.append("text")
      .attr("transform", "translate(10,3)")
      .attr("class", "cursor-changes")
    self.mouseLine.append("text")
      .attr("transform", "translate(10,13)")
      .attr("class", "cursor-date")

    self.mouseMovementRectangle = self.chartCursor.append('svg:rect') // append a rect to catch mouse movements on canvas
      .attr('width', self.width) // can't catch mouse events on a g element
      .attr('height', self.height)
      .attr('fill', 'none')
      .attr('pointer-events', 'all')
    self.mouseMovementRectangle
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
        var xDate = self.x.invert(mouse[0])

        d3.select(".date-marker")
          .attr("d", function() {
            var d = "M" + mouse[0] + "," + self.height;
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
            var d = "M" + mouse[0] + "," + self.height;
            d += " " + mouse[0] + "," + 0;
            return d;
          });

        d3.selectAll(".mouse-per-line")
          .attr("transform", function(d, i) {
            d3.select(this).select('text.cursor-date')
              .text(self.x.invert(mouse[0]).toISOString().split('T')[0])

            return "translate(" + mouse[0] + ",0)";
          });
      });

    this.renderChart();
  }

  renderChart() {
    const self = this;
    const data = self.histogram;

    this.xExtent = d3.extent(data, function(d) {
      return d.date;
    });

    self.x.domain(
      [
        new Date(self.xExtent[0]).setDate(new Date(self.xExtent[0]).getDate()-30),
        new Date(self.xExtent[1]).setDate(new Date(self.xExtent[1]).getDate()+30)
      ]
    );

    self.y.domain([
      0,
      d3.max(data, function(d) {
        return d.value;
      })
    ]);

    self.xAxisElement.call(self.xAxis);

    this.svg
      .selectAll(".change-counts")
      .data(data)
      .enter()
      .append("rect")
      .attr("class", "change-counts")
      .attr("fill", "steelblue")
      .attr("height", d => self.height - self.y(d.value))
      .attr("width", 10)
      .attr("x", (d, i) => self.x(d.date))
      .attr("y", d => self.y(d.value))
  }
}
