sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/core/Component",
    "sap/ui/core/ComponentContainer"    
], (Controller, Component, ComponentContainer) => {
    "use strict";
    

    return Controller.extend("app1.controller.App", {
      onInit: function () {
  

        //   sap.ui.core.Component.create({
        //     name: "ns.scenesweb",
        //     manifest: true,
        //     async: true
        // }).then(function(oComponent) {
        //     const oContainer = new sap.ui.core.ComponentContainer({
        //         height: "100%",
        //         width: "100%",
        //         component: oComponent
        //     });
        
        //     // Add to a VBox or Page in your App1.view.XML
        //     this.getView().byId("myScenesCompArea").addItem(oContainer);
        // }.bind(this));

          //   Component.create({
          //       name: "app2",
          //       url: "/a2app2/",
          //       manifest: true
          //     }).then(function (oComponent) {
          //       this.byId("compContainer").setComponent(oComponent);
          //     }.bind(this));
          //   }
          // });
        // },
        // onTilePress: function () {
          // if (this.oApp2Container) {
          //   this.oApp2Container.destroy();
          //   this.oApp2Container = null;
          // }
          //   // 1) Get reference to 'app1' component
          //   var oApp1Component = this.getOwnerComponent();
            
          //   oApp1Component
          //   .createComponent({
          //     usage: "app2",
          //     manifest: true,
          //     settings: {
          //       id: "app2" + Date.now()
          //     } 
          //   })
          //   .then(function (oSubComponent) {
          //     // 3) Wrap it in a ComponentContainer
          //     var oSubCompContainer = new ComponentContainer({
          //       component: oSubComponent,
          //     });
              
          //     var oSharedModel = oApp1Component.getModel("sharedModel");
          //     oSubComponent.setModel(oSharedModel, "sharedModel");
          //     console.log("APP1 CONTROLLER", oSharedModel.getData());
          //     // 4) Place inside some layout in this view
          //     var oVBox = this.getView().byId("mySubCompArea");
          //     oVBox.addItem(oSubCompContainer);
              
          //   }.bind(this));
          // }
      }});
});