const DATA_URL = "./assets/data/data.json";

const TEMPLATE_LOCATION = `<div class="row location">
              <div class="col-25">
                <img
                  class="img-fluid"
                  src="./assets/images/###@1"
                  alt="###@2"
                />
              </div>
              <div class="col-75">
                <h3 class="title">###@3</h3>
                <p class="description">###@4</p>
              </div>
            </div>`;

const TEMPLATE_INFO_CARD = `<div class="card">
              <div class="card-header">
                <div class="card-img-container">
                  <img
                    class="card-img"
                    src="./assets/images/###@1"
                    alt="###@2"
                  />
                </div>
              </div>
              <div class="card-content">
                <h4 class="title">###@3</h4>
                <p class="description">###@4</p>
              </div>
            </div>`;

const INFO_MAP = {
  "griffith.jpg": "Griffith",
  "mountains.jpg": "Mountains",
  "universalstudios.jpg": "Universal Studios",
};

/**
 * @param {String} HTML representing a single element
 * @return {Element}
 */
function htmlToElement(html) {
  var template = document.createElement("template");
  html = html.trim(); // Never return a text node of whitespace as the result
  template.innerHTML = html;
  return template.content.firstChild;
}

function renderData(data) {
  renderSection2(data["section2"]);
  renderSection3(data["section3"]["text"]);
  renderSection4(data["section4"]);
}

async function renderSection2(infos) {
  const infoCardsDiv = document.getElementById("info-cards");
  infos.forEach((info) => {
    let inf = TEMPLATE_INFO_CARD;
    // Change image
    inf = inf.replace("###@1", info["image"]);
    // Change image alt
    inf = inf.replace("###@2", info["heading"]);
    // Change title
    inf = inf.replace("###@3", info["heading"]);
    // Change text
    inf = inf.replace("###@4", info["text"]);

    // Convert to HTML and return
    infoCardsDiv.appendChild(htmlToElement(inf));
  });
}

async function renderSection3(descriptions) {
  const aboutDiv = document.getElementById("about-la");
  descriptions.forEach((description) => {
    // Create new paragraph and set the text
    let p = document.createElement("p");
    p.appendChild(document.createTextNode(description));

    // Add paragraph to the div
    aboutDiv.appendChild(p);
  });
}

async function renderSection4(locations) {
  const locationsDiv = document.getElementById("locations");
  locations.forEach((location) => {
    let loc = TEMPLATE_LOCATION;
    // Change image
    loc = loc.replace("###@1", location["image"]);
    // Change image alt
    loc = loc.replace("###@2", location["heading"]);
    // Change title
    loc = loc.replace("###@3", location["heading"]);
    // Change text
    loc = loc.replace("###@4", location["text"]);
    // Convert to HTML and return
    locationsDiv.appendChild(htmlToElement(loc));
  });
}

window.addEventListener("load", async function (event) {
  fetch(DATA_URL, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => {
      if (response.status == 200) {
        // Fetched file successfully.
        response.json().then((data) => {
          return renderData(data);
        });
      } else {
        alert(
          "There was an error getting data from the server. Please contact the site's administrator."
        );
      }
    })
    .catch((err) =>
      alert(
        "There was an error getting data from the server. Please contact the site's administrator."
      )
    );
});
