sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns.scenesweb',
            componentId: 'ScenesObjectPage',
            contextPath: '/Scenes'
        },
        CustomPageDefinitions
    );
});