import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let chart = new d3.OrgChart()
      .container('.chart-container')
      // .data(this.data.get("orgData"))
      .data([{"id":"0c82829d-c4ec-4b87-b743-01dd7b1e68bf","name":"Cerie Xerox","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Assistant","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-8008S","isContractor":false},{"id":"473330ed-dafd-4f19-8c5d-a9d5191b833a","name":"Toofer Spurlock","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Writer","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-313V5","isContractor":false},{"id":"79cf8205-0896-433c-84fe-ba5da231e817","name":"Johnny Lutz","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Writer","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-747S3","isContractor":false},{"id":"f70c9f69-c2c7-4e5a-8bbb-abc2034d58f8","name":"Frank Rossitano","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Writer","image_url":"https://carboncostume.com/wordpress/wp-content/uploads/2013/05/frankrossitano.jpg","employee_id":"NBC-494T7","isContractor":false},{"id":"b2189701-53f0-46c6-9586-a256e642a297","name":"Josh Girard","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Actor/Writer","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-684N0","isContractor":false},{"id":"2528c630-ef96-4be8-adf6-9b331b19cef7","name":"Jenna Maroney","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Actor","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-503Y2","isContractor":false},{"id":"5b6c43cf-5e7c-4d26-9b3e-4d19c74a3857","name":"Warren \"Grizz\" Griswald","parentId":"8f8a894b-3340-4e4e-bc4f-f03bd80f6b2c","title":"Talent Manager","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"","isContractor":true},{"id":"331e428a-f89c-428a-b232-fc021ea0c8ca","name":"Walter \"Dot Com\" Slattery","parentId":"8f8a894b-3340-4e4e-bc4f-f03bd80f6b2c","title":"Entrepreneur","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"","isContractor":true},{"id":"8f8a894b-3340-4e4e-bc4f-f03bd80f6b2c","name":"Tracy Jordan","parentId":"4176cdf6-10da-405f-aef9-d7146d7afd44","title":"Actor","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-923H5","isContractor":false},{"id":"18300753-635b-49ff-8ca9-90fd5331bb30","name":"Kenneth Parcell","parentId":"57fd399f-78e9-4c3d-a63a-dfd4b4584c83","title":"Page","image_url":"https://www.gravatar.com/avatar/?s=50","employee_id":"NBC-435R2","isContractor":false},{"id":"81fa4dad-dae6-444f-b40f-ba8a211a3308","name":"Jonathan ","parentId":"246562da-80c2-4cee-995e-1ca6fe8afd1a","title":"Assistant","image_url":"https://www.hollywoodreporter.com/wp-content/uploads/2012/08/maulik_pancholy_a_p.jpg","employee_id":"NBC-981D7","isContractor":false},{"id":"57fd399f-78e9-4c3d-a63a-dfd4b4584c83","name":"Pete Hornberger","parentId":"246562da-80c2-4cee-995e-1ca6fe8afd1a","title":"Producer","image_url":"https://screenfiction.org/content/image/0/113/668/0a9e4d88-regular.webp","employee_id":"NBC-386D3","isContractor":false},{"id":"4176cdf6-10da-405f-aef9-d7146d7afd44","name":"Liz Lemon","parentId":"246562da-80c2-4cee-995e-1ca6fe8afd1a","title":"Head Writer","image_url":"https://otb.cachefly.net/wp-content/uploads/2010/03/Tina-Fey-Liz-Lemon.jpg","employee_id":"NBC-22B75","isContractor":false},{"id":"246562da-80c2-4cee-995e-1ca6fe8afd1a","name":"Jack Donaghy","parentId":null,"title":"Vice President of East Coast Television and Microwave Oven Programming","image_url":"https://www.beverlyhillsmagazine.com/wp-content/uploads/beverly-hills-magazine-alec-baldwin-hollywood-celebrities-famous-actors-1.jpg","employee_id":"NBC-279F0","isContractor":false}])
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
