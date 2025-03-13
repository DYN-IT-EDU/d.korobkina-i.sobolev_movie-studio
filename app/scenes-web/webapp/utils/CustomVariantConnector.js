sap.ui.define([
    "sap/ui/fl/write/api/connectors/ObjectStorageConnector"
], function (ObjectStorageConnector) {
    "use strict";

    return ObjectStorageConnector.extend("custom.Connector", {
        loadFlexData: async function (mPropertyBag) {
            return fetch("/odata/v4/variant-service/Variants", {
                headers: {
                    "Authorization": "Bearer " + localStorage.getItem("token") // если нужна аутентификация
                }
            })
            .then(response => response.json())
            .then(data => ({ changes: data.value }));
        },

        write: async function (mPropertyBag) {
            return fetch("/odata/v4/variant-service/SAVE_VARIANT", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer " + localStorage.getItem("token")
                },
                body: JSON.stringify(mPropertyBag)
            });
        },

        remove: async function (mPropertyBag) {
            return fetch("/odata/v4/variant-service/DELETE_VARIANT", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer " + localStorage.getItem("token")
                },
                body: JSON.stringify({ ID: mPropertyBag.ID })
            });
        }
    });
});
