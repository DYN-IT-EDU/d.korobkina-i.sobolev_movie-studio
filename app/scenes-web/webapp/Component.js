sap.ui.define([
        "sap/fe/core/AppComponent",
        "sap/ui/core/UIComponent",
    ],
    function (Component) {
        "use strict";
        console.log("Scenes component loaded");
        
        return Component.extend("ns.scenesweb.Component", {
            metadata: {
                manifest: "json"
            },
            init: function () {
                Component.prototype.init.apply(this, arguments);
                console.log("ns.scenesweb Component initialized");
            }
        });
    }
);