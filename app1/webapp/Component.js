sap.ui.define([
    "sap/ui/core/UIComponent",
    "app1/model/models"
], (UIComponent, models) => {
    "use strict";

    return UIComponent.extend("app1.Component", {
        metadata: {
            manifest: "json",
            interfaces: [
                "sap.ui.core.IAsyncContentCreation"
            ]
        },

        init() {
            // call the base component's init function
            UIComponent.prototype.init.apply(this, arguments);

            // set the device model
            this.setModel(models.createDeviceModel(), "device");
            
            // var oModel = new sap.ui.model.json.JSONModel({
            //     greeting: "Hello from Parent",
            //   }); 
            //   this.setModel(oModel, "sharedModel");
            //   // console.log("model itself look:", )
            //   console.log("COMPONENT.JS model data:", oModel.getData('greeting',))
            // // enable routing
            this.getRouter().initialize();
        }
    });
});