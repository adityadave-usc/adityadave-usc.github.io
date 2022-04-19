import "./App.css";
import React from "react";
import * as ReactDOM from "react-dom";
import { Map } from "@esri/react-arcgis";
import { Scene } from "@esri/react-arcgis";
import { WebMap, WebScene } from "@esri/react-arcgis";
import Campus from "./Campus";

// 3.1
// function App() {
//   return ReactDOM.render(
//     <div style={{ width: "100vw", height: "100vh" }}>
//       <Map />,
//     </div>,
//     document.getElementById("container")
//   );
// }

// 3.2
// function App() {
//   return ReactDOM.render(
//     <div style={{ width: "100vw", height: "100vh" }}>
//       <Scene />,
//     </div>,
//     document.getElementById("container")
//   );
// }

// 3.3
// function App() {
//   return ReactDOM.render(
//     <div style={{ width: "100vw", height: "100vh" }}>
//       <WebMap id="fe5d321326c94cadba1c45d6587b566f" />,
//     </div>,
//     document.getElementById("container")
//   );
// }

// 3.4
// function App() {
//   ReactDOM.render(
//     <div style={{ width: "100vw", height: "100vh" }}>
//       <WebScene id="f8aa0c25485a40a1ada1e4b600522681" />,
//     </div>,
//     document.getElementById("container")
//   );
// }

// export default App;

// 4
function App() {
  // like we started out with
  ReactDOM.render(<WebScene />, document.getElementById("container"));
} // App()

// INSTEAD of 'export default App;'
export default (props) => (
  <Scene
    style={{ width: "70vw", height: "90vh" }}
    //mapProperties={{ basemap: 'satellite' }}
    viewProperties={{
      center: [-118.28538, 34.0205],
      zoom: 15,
    }}
  >
    <Campus />
  </Scene>
);
