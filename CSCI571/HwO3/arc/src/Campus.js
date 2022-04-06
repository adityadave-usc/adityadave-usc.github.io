import { useState, useEffect } from "react";
import { loadModules } from "esri-loader";

const Campus = (props) => {
  const [graphic, setGraphic] = useState(null);
  useEffect(() => {
    loadModules(["esri/Graphic"])
      .then(([Graphic]) => {
        // Create a polygon geometry
        const polygon = {
          type: "polygon", // autocasts as new Polygon()
          rings: [
            [-118.28525268015703, 34.02537001359202], // USC Village Fountain
            [-118.28943742136676, 34.02484509773376], // Jefferson Parking Structure
            [-118.29052502767503, 34.020057791004554], // USC School of Gerontology
            [-118.2887938917776, 34.01970507233271], // Science Library
            [-118.28369884564277, 34.020182184844934], // Dohney Library
            [-118.28289812638427, 34.02090030045081], // Leavey Lawn
          ],
        };

        // Create a symbol for rendering the graphic
        const fillSymbol = {
          type: "simple-fill", // autocasts as new SimpleFillSymbol()
          color: [200, 0, 20, 0.25],
          outline: {
            // autocasts as new SimpleLineSymbol()
            color: [255, 255, 255],
            width: 1,
          },
        };

        // Add the geometry and symbol to a new graphic
        const graphic = new Graphic({
          geometry: polygon,
          symbol: fillSymbol,
        });
        setGraphic(graphic);
        props.view.graphics.add(graphic);
      })
      .catch((err) => console.error(err));

    return function cleanup() {
      props.view.graphics.remove(graphic);
    };
  }, []);

  return null;
};

export default Campus;
