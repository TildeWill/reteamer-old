import { Controller } from "@hotwired/stimulus"
import { OrgChart } from 'd3-org-chart';

export default class extends Controller {
  connect() {
    const container = document.createElement("div");
    container.className = 'chart-container'
    this.element.appendChild(container);

    let chart = new OrgChart()
      .container('.chart-container')
      .data(JSON.parse(this.data.get("orgData")))
      // .connections(
      //   [
      //     { id: 1, from: "008680b1-2c41-429e-a37c-fd4c1263ab11", to: "d07b0568-989a-4453-b8df-45476b7055c4", label: "Mushroom Hunting Team" },
      //   ],
      // )
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
                <img src="${d.data.image_url || ''}" style="margin-top:-30px;margin-left:${d.width / 2 - 30}px;border-radius:100px;height:60px;overflow:hidden" />

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
      .render();
    chart.expandAll();

  }
}
