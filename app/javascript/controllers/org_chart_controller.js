import { Controller } from "@hotwired/stimulus"
import { OrgChart } from 'd3-org-chart';
import * as d3 from "d3"

export default class extends Controller {

  exportSvg() {
    this.chart.fit();
    this.chart.exportSvg()
  }

  fit() {
    this.chart.fit();
  }

  async handleDatePicked(event) {
    const response = await fetch(`/api/org_chart.json?effective_date=${event.detail.newDate}`)
    this.orgData = await response.json()
    this.chart
      .data(this.orgData.people)
      .connections(this.orgData.connections)
      .render()
      .expandAll()
      .fit()
  }

  async connect() {
    const response = await fetch('/api/org_chart.json')
    this.orgData = await response.json()

    const container = document.createElement("div");
    container.className = 'chart-container'
    this.element.appendChild(container);

    this.chart = new OrgChart()
      .container('.chart-container')
      .data(this.orgData.people)
      .connections(this.orgData.connections)
      .connectionsUpdate(function (d, i, arr) {
        d3.select(this)
          .attr('stroke', (d) => '#CCCCCC')
          .attr('stroke-linecap', 'round')
          .attr('stroke-width', (d) => '2')
          .attr('pointer-events', 'none')

           // .attr("marker-start", d => `url(#${d.from + "_" + d.to})`)
          //  .attr("marker-end", d => `url(#arrow-${d.from + "_" + d.to})`)
          .attr('stroke-dasharray', '20, 20');
      })
      .nodeWidth(d => 250)
      .initialZoom(0.7)
      .nodeHeight(d => 200)
      .childrenMargin(d => 40)
      .compactMarginBetween(d => 15)
      .compactMarginPair(d => 80)
      .nodeContent(function(d, index, arr, state) {
        return `
            <div style="padding-top:30px;background-color:none;margin-left:1px;height:${
          d.height
        }px;border-radius:2px;overflow:visible">
              <div style="height:${d.height - 32}px;padding-top:0px;background-color:white;border:1px solid lightgray;">
                <img src="${d.data.image_url || ''}" style="margin-top:-30px;margin-left:${d.width / 2 - 30}px;border-radius:100px;height:60px;width:60px;overflow:hidden" />

                <div style="margin-right:10px;margin-top:15px;float:right">${
          d.data.employee_id || 'Contractor'
        }</div>

                <div style="margin-top:-30px;background-color:${d.data.isContractor ? '#FF9036' : '#3AB6E3'};height:10px;width:${d.width -
        2}px;border-radius:1px"></div>

                <div style="padding:20px; padding-top:35px;text-align:center">
                  <div style="color:#111672;font-size:16px;font-weight:bold"> ${
          d.data.name
        } </div>
                  <div style="color:#404040;font-size:16px;margin-top:4px"> ${
          d.data.title
        } </div>
                </div>
                ${d.data._directSubordinates > 0 ? `
                <div style="display:flex;justify-content:space-between;padding-left:15px;padding-right:15px;">
                  <div > Manages:  ${d.data._directSubordinates} 👤</div>
                  <div > Oversees: ${d.data._totalSubordinates} 👤</div>
                </div>` : ""}
              </div>
            </div>
  `;
      })
      .render()
      .expandAll()
      .fit()
  }
}
