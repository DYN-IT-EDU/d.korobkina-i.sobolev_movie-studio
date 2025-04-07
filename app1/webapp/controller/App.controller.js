sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/core/Component",
    "sap/ui/core/ComponentContainer"    
], (Controller, Component, ComponentContainer) => {
    "use strict";
    

    return Controller.extend("app1.controller.App", {
      onInit: function () {},

      onNavToSecond: function() {
        const oRouter = this.getOwnerComponent().getRouter();
        oRouter.navTo("SecondPage");
    },});
});