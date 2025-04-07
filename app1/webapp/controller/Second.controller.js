sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/core/Component",
  "sap/ui/core/ComponentContainer"
], function (Controller, Component, ComponentContainer) {
  "use strict";

  return Controller.extend("app1.controller.Second", {
    onInit: function () {
      var oCompCont = this.byId("scenesContainer2");
      if (oCompCont) {
        var oComponent = oCompCont.getComponent();
        if (oComponent) {
          var oRouter = oComponent.getRouter();
          if (oRouter) {
            oRouter.initialize();
            oRouter.navTo("ScenesList");
          }
        }
      }
    },
    //   Component.create({
    //     name: "ns.scenesweb",
    //     id: "scenesComp2",
    //     manifest: true,
    //     async: true
    //   }).then(function (oComponent) {
    //     const oContainer = new ComponentContainer({
    //       component: oComponent,
    //       height: "100%",
    //       width: "100%"
    //     });

    //     this.byId("containerBox").removeAllItems();
    //     this.byId("containerBox").addItem(oContainer);

    //     const oRouter = oComponent.getRouter();
    //     oRouter.initialize(); // Start internal routing
    //     oRouter.navTo("ScenesList");
    //   }.bind(this));  
    // },

    onNavBack: function () {
      this.getOwnerComponent().getRouter().navTo("main");
    }
  });
});
